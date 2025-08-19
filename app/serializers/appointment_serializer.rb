class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :professional_name, :user_name, :start_time

  def professional_name
    object.professional.name
  end

  def user_name
    object.user.name
  end
end
