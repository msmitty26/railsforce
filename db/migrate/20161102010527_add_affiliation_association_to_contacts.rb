class AddAffiliationAssociationToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :affiliation_id, :integer
  end
end
