class AddAmountOwedToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :amount_owed, :integer
  end
end
