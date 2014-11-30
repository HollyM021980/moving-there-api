require 'rails_helper'
RSpec.describe "Users", :type => :request do

  # let(:json) { JSON.parse(response.body) }

  describe "GET /users.json" do
  let(:valid_session) { {} }

    context 'all users' do
      before do
        @user_listing = FactoryGirl.create_list(:user, 10)
        get '/users.json', {:format => :json}
        @users_response = JSON.parse(response.body)
      end

      it "successfully responds" do
        expect(response).to be_success
      end

      it 'returns the right number of user records' do
        expect(@users_response.length).to eq(10) # check to make sure the right amount of

      end

      #TODO: This needs to be refined to be more specific to the data
      it "contains the right information" do
        expect(@users_response.all? {|usr| usr.key?('id')}).to eq(true)
      end

      it "doesn't return private attributes" do
        expect(@users_response[0]['password_digest']).to eq(nil)
        expect(@users_response[0]['token']).to eq(nil)
      end
    end
  end

  describe "GET single user" do
    context 'one user' do
      before do
        @one_user= FactoryGirl.create(:user)
        ind = @one_user.id
        get "/users/#{ind}.json", {:format => :json}
        @user_response = JSON.parse(response.body)
      end

      it "successfully responds" do
        expect(response).to be_success
      end

      it "contains the right information" do
        expect(@user_response['email']).to eq(@one_user.email)
        expect(@user_response['first_name']).to eq(@one_user.first_name)
        expect(@user_response['last_name']).to eq(@one_user.last_name)
     end

      it "doesn't return private attributes" do
        expect(@user_response['password_digest']).to be_nil
        expect(@user_response['token']).to be_nil
        expect(@user_response['created_at']).to be_nil
        expect(@user_response['updated_at']).to be_nil
      end
    end
  end
end
