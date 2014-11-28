class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @users = User.all
    # respond_with(@users)
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    @user.save
    render json: @user
  end

  def update
    @user.update(user_params)
    render json: @user
  end

  def destroy
    @user.destroy
    render json: @user
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :token, :password_digest, :role)
    end
end
