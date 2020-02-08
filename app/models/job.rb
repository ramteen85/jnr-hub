class Job < ApplicationRecord
  # User has many jobs
  belongs_to :user
end
