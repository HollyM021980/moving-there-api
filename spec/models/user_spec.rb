require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build_stubbed(:user)).to be_valid
  end

  it "is invalid without an email" do
    user = FactoryGirl.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password digest" do
    user = FactoryGirl.build(:user, password_digest: nil)
    user.valid?
    expect(user.errors[:password_digest]).to include("can't be blank")
  end

  it "is invalid without a token" do
    user = FactoryGirl.build(:user, token: nil)
    user.valid?
    expect(user.token).not_to be_present
  end

  it "saves with a token" do
    user = FactoryGirl.create(:user)
    user.valid?
    expect(user.token).to be_present
  end


end
