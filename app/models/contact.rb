class Contact < ApplicationRecord
#  belongs_to :user
  belongs_to :affiliation, optional: true

  validates_presence_of :first_name, :last_name, :email_address, :organization
  validates :phone_number, format: { with: /\d{3}-\d{3}-\d{4}/, message: "format is invalid" }
end
