class CreateOpenidAccounts < ActiveRecord::Migration
  def self.up
    create_table :openid_accounts do |t|
      t.integer :user_id
      t.string :claimed_id
      t.string :identity

      t.timestamps
    end
  end

  def self.down
    drop_table :openid_accounts
  end
end
