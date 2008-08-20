class CreateOpenidAccounts < ActiveRecord::Migration
  def self.up
    create_table :openid_accounts do |t|
      t.string :claimed_id

      t.timestamps
    end
  end

  def self.down
    drop_table :openid_accounts
  end
end
