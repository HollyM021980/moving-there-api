require 'pry'
class UsersController < ApplicationController

  before_filter :authenticate, except: [:login, :logout, :signup, :index]

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: {"token" => user.token}
    else
      head :unauthorized
    end
  end

  def logout
    head :ok
  end

  def index
    @users = User.all
  end

  def show
  #   render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @user.update(user_params)
    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :token, :password, :password_confirmation, :role)
    end
end
