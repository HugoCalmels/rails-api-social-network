class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.belongs_to :receiver, null: false# remove,foreign_key:true
      t.belongs_to :sender, null: false# remove,foreign_key:true
      t.boolean :confirmed
      t.boolean :seen, default: false

      t.timestamps
    end
  end
end
