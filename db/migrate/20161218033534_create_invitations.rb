class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.string  :email
      t.string  :token
      t.text    :message
      t.integer :inviter_id
      t.integer :invitee_id
      t.timestamps null: false
    end
  end
end
