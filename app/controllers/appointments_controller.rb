class AppointmentsController < ApplicationController
  before_action :appointment_params, only: %i[ create]
  def index
  end

  def create
    appointment = Appointment.new(appointment_params)

    if appointment.save!
      render json: appointment, status: :created
    else
      render json: { errors: appointment.errors.full_message}, status: :unprocessable_entity
    end
  end

  def appointment_params
    params.require(:appointment).permit(:user_id, :professional_id)
  end
end
