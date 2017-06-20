class AddDateLastPaidToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :date_last_paid, :date
  end
end
