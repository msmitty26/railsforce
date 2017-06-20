class AddAmountPaidToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :amount_paid, :integer
  end
end
