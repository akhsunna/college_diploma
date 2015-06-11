class CreateInviteCodes < ActiveRecord::Migration
  def up
    create_table :invite_codes do |t|
      t.string :role
      t.references :group
      t.string :token, size: 10
    end
  end

  def down
    drop_table :invite_codes
  end
end
