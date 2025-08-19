ActiveRecord::Base.transaction do
  10.times do
    User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.unique.email
    )

  Professional.create!(
    name: Faker::Name.name,
    specialty: Professional.specialties.keys.sample
  )

  end
rescue => e
  puts e.message
end