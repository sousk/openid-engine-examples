require 'base64'
class OpenidAssociation < ActiveRecord::Base
  def expired?
    created_at + lifetime < Time.now
  end
end
