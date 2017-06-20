class AddAttributesToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :address_1, :string
    add_column :contacts, :address_2, :string
    add_column :contacts, :city, :string
    add_column :contacts, :state, :string
    add_column :contacts, :zip, :integer
    add_column :contacts, :business_size, :string
  end
end
