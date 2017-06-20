class Contact < ApplicationRecord
#  belongs_to :user
  belongs_to :affiliation, optional: true

  validates_presence_of :first_name, :last_name, :email_address, :organization
  validates :phone_number, format: { with: /\d{3}-\d{3}-\d{4}/, message: "format is invalid" }, :allow_blank => true
  
  def self.search_by_contact_full_name(simple_query)
    where("CONCAT_WS(' ', first_name, last_name) LIKE :q", :q => "%#{simple_query}%")
  end
  
  def find_by_first_name(first_name)
    Contact.find(first_name)
  end
  
  def find_by_last_name(last_name)
    Contact.find(last_name)
  end
  
  def find_by_email_address(email_address)
    Contact.find(email_address)
  end
  
  def find_by_organization(organization)
    Contact.find(organization)
  end
  
  def find_by_affiliation(affiliation)
    Contact.where(:affiliation => affiliation)
  end
  
end
