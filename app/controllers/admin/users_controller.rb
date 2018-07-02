class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy, :edit, :update]
  before_action :skip_password, only: [:update]

  def index
    @users = User.order(:created_at => "DESC").page
  end

  def new
    @user = User.new
  end

  # Audit comment working
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user , :notice => "User created successfully."
    else
      render 'new', :alert => "Unable to create User!"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user , :notice => "User updated successfully."
    else
      render 'edit', :alert => "Unable to update User!"
    end
  end

  def show
  end

  def destroy
    users_email = @user.email
    if @user.id != current_user.id && @user.destroy
      redirect_to users_path , :notice => "User deleted successfully."
    end
  end

  private
  def current_admin_user
    current_user.email
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
  end

  def skip_password
    @user.skip_password_validation = true if current_user.admin?
  end
end
