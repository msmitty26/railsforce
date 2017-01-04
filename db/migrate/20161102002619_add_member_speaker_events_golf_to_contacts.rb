class AddMemberSpeakerEventsGolfToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :member, :boolean
    add_column :contacts, :speaker, :boolean
    add_column :contacts, :events, :boolean
    add_column :contacts, :golf, :boolean
  end
end
