require 'rails_helper'
RSpec.describe UsersController, :type => :controller do

  before(:each) do
    @request.env["HTTP_ACCEPT"] = "application/json"
    @request.env["CONTENT_TYPE"] = "application/json"
  end


  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {email: "u21@test.com",
    first_name: "First21",
    last_name: "Last21",
    password: "test",
    password_digest: "test",
    role: :user
    }
  }

  let(:invalid_attributes) {
    {
      email: "invalid"
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all users as @users" do
      user = User.create! valid_attributes
      get :index, valid_session
      expect(assigns(:users)).to eq([user])
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = FactoryGirl.create(:user)
      get :show, {:id => user.to_param}, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end


  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "returns a status of 201 - Created" do
        post :create, {:user => valid_attributes}, valid_session
        expect(response.status).to eq(201)
     end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, {:user => invalid_attributes}, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "returns status 422 - Unprocessable Entity" do
        post :create, {:user => invalid_attributes}, valid_session
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {
          email: "test212@test.com",
          first_name: "First212",
          last_name: "Last212"
        }

      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => new_attributes}, valid_session
        user.reload
        expect(user.first_name).to eq new_attributes[:first_name]
        expect(user.last_name).to eq new_attributes[:last_name]
        expect(user.email).to eq new_attributes[:email]
      end

      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "returns a status of 204 - no content" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        expect(response.status).to eq(204)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => invalid_attributes}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "returns 422 status - Unprocessable Entity" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => invalid_attributes}, valid_session
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, {:id => user.to_param}, valid_session
      }.to change(User, :count).by(-1)
    end

    it "returns status of 204 - no content" do
      user = User.create! valid_attributes
      delete :destroy, {:id => user.to_param}, valid_session
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
