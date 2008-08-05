require File.dirname(__FILE__) + '/../spec_helper'

describe OpenidAssociation do
  fixtures :openid_associations
  before(:each) do
    @assoc = openid_associations(:localhost_sha256)
  end

  it "should be valid" do
    @assoc.should be_valid
  end
  
end
