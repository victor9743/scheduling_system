class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ destroy ]
  before_action :appointment_params, only: %i[ create]
  rescue_from ActiveRecord::RecordNotFound, with: :appointment_not_found

  def index
    appointments = Appointment.all
    render json: appointments
  end

  def create
    appointment = Appointment.new(appointment_params)
    new_start = Time.now + 30.minutes
    new_end = new_start + 30.minutes

    conflict = Appointment.where(professional_id: appointment.professional_id)
                          .where("start_time < ? AND start_time + interval '30 minutes' > ?", new_end, new_start)
                          .exists?

    if conflict
      render json: { error: "Schedule unavailable" }, status: :unprocessable_entity
    elsif check_new_start(new_start, new_end)
      render json: { error: "Appointments can only be scheduled during business hours (Mon-Fri, 09:00-17:00)" }, status: :unprocessable_entity
    elsif appointment.save!
      render json: appointment, status: :created
    else
      render json: { errors: appointment.errors.full_message}, status: :unprocessable_entity
    end
  end

  

  def destroy
    if @appointment.destroy
      render json: { message: "appointment successfully deleted"}, status: :ok
    else
      render json: { message: "Failed to create appointment", errors: @appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:user_id, :professional_id)
  end

  def appointment_not_found
    render json: { message: "Appointment not found" }, status: :not_found
  end

  def check_new_start(new_start, new_end)
    if new_start.saturday? || new_start.sunday? || new_start.hour < 9 || new_end.hour > 17
      return true
    end
  end
end
