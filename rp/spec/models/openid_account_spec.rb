require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OpenidAccount do
  fixtures :openid_accounts, :users
  
  before(:each) do
    @openid_account = OpenidAccount.new
    @quentin = users(:quentin)
  end

  it "should be valid" do
    @openid_account.should be_valid
    @openid_account.should respond_to(:claimed_id)
    @openid_account.should respond_to(:identity)
  end
  
  it "should be associated with a User" do
    @openid_account.should respond_to(:user)
  end
  
  it "should retrieve the user which openid account belongs" do
    account = openid_accounts(:quentin)
    account.user.should == @quentin
  end
end
