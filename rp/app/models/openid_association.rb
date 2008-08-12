require "base64"

class OpenidAssociation < ActiveRecord::Base
  class << self
    def new_from_response(endpoint, response) #FIXME should be obsoleted
      new :op_endpoint => endpoint,
        :handle => response[:assoc_handle],
        :encryption_type => response[:assoc_type],
        :secret => response[:secret],
        :lifetime => response[:expires_in].to_i
    end
  end
  
  def expired? #FIXME should be obsoleted
    created_at + lifetime < Time.now
  end
end
