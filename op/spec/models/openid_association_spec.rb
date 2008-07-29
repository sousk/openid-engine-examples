require File.dirname(__FILE__) + '/../spec_helper'

describe OpenidAssociation do
  before(:each) do
    @openid_association = OpenidAssociation.new
  end

  it "should be valid" do
    @openid_association.should be_valid
  end
  
  describe "#expired?" do
    fixtures :openid_associations
    
    it "should return true if expired" do
      assoc = openid_associations(:assoc_sha256_expired)
      assoc.should be_expired
    end
    
    it "should return false if not expired" do
      assoc = openid_associations(:assoc_sha256)
      assoc.should_not be_expired
    end
  end
end
