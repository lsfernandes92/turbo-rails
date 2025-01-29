class User < ApplicationRecord
  # The feature to sign in users (:database_authenticatable)
  # The feature to validate the email and password using Devise built-in
  # validations (:validatable)
  devise :database_authenticatable, :validatable

  belongs_to :company

  def name
    email.split("@").first.capitalize
  end
end
