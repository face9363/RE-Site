module V3
  class UsersController < ApplicationController
  before_action :authenticate!, only: [:update, :destroy, :me]

  # GET /users
  def index
    @users = User.all
    render json: @users.map{|u| u.public_return}
  end

  def me
    @current_user = current_user
    render json:
               {
                  user: @current_user.public_return,
                  token: @current_user.token
               }
  end

  # GET /users/1
  def show
    render json: set_user.public_return
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json:
                 {
                     user: @user.public_return,
                     token: @user.token
                 },
      status: :created, location: v3_user_path(@user.id)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    @user = current_user
    if @user.update(user_params)
      render json: @user.public_return
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user = current_user
    @user.destroy
  end

  def log_in
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      # @user.regenerate_token
      render json: @user.as_json(only: [:id, :name, :email, :token, :image])
    else
      render json: { errors: ['cannot logged_in'] }, status: 401
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:name, :email, :password, :password_confirmation, :image)
    end
  end
end
