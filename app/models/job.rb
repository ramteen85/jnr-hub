class Job < ApplicationRecord
  # User has many jobs
  has_many :applications
  belongs_to :user, optional: true
end
