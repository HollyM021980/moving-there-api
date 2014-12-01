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

  context "verify email address is valid" do
    it {should validate_email_format_of(:email).with_message("does not appear to be a valid e-mail address")}
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

  # Use shoulda-matchers to validate uniquness
  context "uniqueness validations" do
    subject { FactoryGirl.build(:user) }

    it { should validate_uniqueness_of(:email)}
    it { should validate_uniqueness_of(:token)}
  end

end
