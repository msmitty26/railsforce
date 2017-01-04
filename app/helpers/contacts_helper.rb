module ContactsHelper
  def contact_affiliation_name(affiliation_id)
    Affiliation.find(affiliation_id).name unless affiliation_id.blank?
  end
end
