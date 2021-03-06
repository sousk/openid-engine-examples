class CreateOpenidAssociations < ActiveRecord::Migration
  def self.up
    create_table :openid_associations do |t|
      t.string :handle, :encryption_type, :null => false
      t.binary :secret, :null => false
      t.integer    :lifetime, :null => false
      # t.datetime :expiration, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :openid_associations
  end
end
