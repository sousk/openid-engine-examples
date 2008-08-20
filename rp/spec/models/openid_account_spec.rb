require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OpenidAccount do
  before(:each) do
    @openid_account = OpenidAccount.new
  end

  it "should be valid" do
    @openid_account.should be_valid
  end
end
