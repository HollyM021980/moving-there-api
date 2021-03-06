require 'rails_helper'
RSpec.describe UsersController, :type => :controller do
  render_views

  let(:json_response) { JSON.parse(response.body) }
  let(:valid_attributes) {
      {email: "u21@test.com",
      first_name: "First21",
      last_name: "Last21",
      password: "test",
      password_confirmation: "test",
      }
    }

  let(:invalid_attributes) {
    {
      email: "invalid"
    }
  }

  before(:each) do
    @auth_user = FactoryGirl.create :user
  end


  describe "GET /users.json" do

    context 'all users' do
      before do
        @user_listing = FactoryGirl.create_list(:user, 10)
        get :index, format: :json
      end

      it "successfully responds" do
        expect(response.status).to eq(200)
      end

      it 'returns the users' do
        expect(json_response.collect{|user| user["email"]}).to include(@auth_user.email)
      end

      it 'returns the right number of user records' do
        # List plus auth user
        expect(json_response.length).to eq(11)
      end
    end
  end

  describe "POST signup" do
    describe "with valid params" do

      it "creates a new User" do
        expect {
          post :signup, {:user => valid_attributes}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly signupd user as @user" do
        post :signup, {:user => valid_attributes}
        expect(assigns(:user)).to be_a(User)
      end

      it "returns a status of 201 - Created" do
        post :signup, {:user => valid_attributes}
        expect(response.status).to eq(201)
     end
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before do
        @request.env['HTTP_AUTHORIZATION'] = "Token token=#{@auth_user.token}"
      end

      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}
        expect(assigns(:user)).to be_a(User)
      end

      it "returns a status of 201 - Created" do
        post :create, {:user => valid_attributes}
        expect(response.status).to eq(201)
      end

      describe "with invalid params" do

        it "does not create a user without all required attributes" do
          post :signup, {:user => invalid_attributes}
          expect(assigns(:user)).to be_a_new(User)
        end

        it "returns status 422 - Unprocessable Entity" do
          post :signup, {:user => invalid_attributes}
          expect(response.status).to eq(422)
        end
      end
    end

    describe "with invalid params" do

      before do
        @request.env['HTTP_AUTHORIZATION'] = "Token token=#{@auth_user.token}"
      end

      it "does not save a user without all required attributes" do
        post :create, {:user => invalid_attributes}
        expect(assigns(:user)).to be_a_new(User)
      end

      it "returns status 422 - Unprocessable Entity" do
        post :create, {:user => invalid_attributes}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "GET show" do
    before do
      @user = FactoryGirl.create :user
      @request.env['HTTP_AUTHORIZATION'] = "Token token=#{@auth_user.token}"
      get :show, :format => :json, id: @user.id
    end

    it "successfully responds" do
      expect(response.status).to eq(200)
    end

    it "assigns the requested user as @user" do
      expect(json_response["email"]).to eq(@user.email)
    end

    it "contains the right information" do
      expect(json_response['email']).to eq(@user.email)
      expect(json_response['first_name']).to eq(@user.first_name)
      expect(json_response['last_name']).to eq(@user.last_name)
    end

    it "doesn't return private attributes" do
      expect(json_response['password_digest']).to be_nil
      expect(json_response['token']).to be_nil
      expect(json_response['created_at']).to be_nil
      expect(json_response['updated_at']).to be_nil
    end
  end




  describe "PUT update" do
    let(:new_attributes) {
      {
         first_name: "First212",
        last_name: "Last212",
        email: "test212@test.com"
      }
    }
    context "with valid params" do
      before do
       @user = FactoryGirl.create :user
       @request.env['HTTP_AUTHORIZATION'] = "Token token=#{@auth_user.token}"

       patch :update, format: :json, id: @user.id, :user => {first_name: new_attributes[:first_name], last_name: new_attributes[:last_name], email: new_attributes[:email]}
      end

      it "updates the requested user" do
        @user.reload
        expect(@user.first_name).to eq new_attributes[:first_name]
        expect(@user.last_name).to eq new_attributes[:last_name]
        expect(@user.email).to eq new_attributes[:email]
      end

      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}
        expect(assigns(:user)).to eq(user)
      end

      it "returns a status of 204 - no content" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}
        expect(response.status).to eq(204)
      end
    end

    context "with invalid params" do
      before do
       @user = FactoryGirl.create :user
       @request.env['HTTP_AUTHORIZATION'] = "Token token=#{@auth_user.token}"

       patch :update, format: :json, id: @user.id, :user => { email: invalid_attributes[:email]}
      end


      it "returns 422 status - Unprocessable Entity" do
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @request.env['HTTP_AUTHORIZATION'] = "Token token=#{@auth_user.token}"
    end

    it "destroys the requested user" do
      expect {
        delete :destroy, format: :json, id: @user
      }.to change(User, :count).by(-1)
    end

    it "returns status of 204 - no content" do
      delete :destroy, format: :json, id: @user
      expect(response.status).to eq(204)
    end
  end

  context "authentication" do
    let(:user) {FactoryGirl.create :user, password: "12345678", password_confirmation:  "12345678"}

    it "authenticates correctly returning the user token" do
      post :login, :email => user.email, :password => user.password, :format => "json"
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json["token"]).to eq user.token
    end

    it "fails authentication" do
      post :login, :email => user.email, :password => "invalid", :format => "json"
      expect(response.status).to eq(401)
    end

    it "successfully logs user out" do
      post :logout, :email => user.email, :password => user.password, :format => "json"
      expect(response.status).to eq(200)
    end
  end

end
