class Professional < ApplicationRecord
  validates :name, presence: true

  enum specialty: {
    nutritionist: 0,
    psychologist: 1,
    physiotherapist: 2,
    personal_trainer: 3,
    therapist: 4
  }
end
