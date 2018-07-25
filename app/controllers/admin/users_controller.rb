class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy, :edit, :update]
  before_action :skip_password, only: [:update]

  def index
    @users = User.order(:created_at => "DESC").page
    authorize @users
  end

  def show
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  # Audit comment working
  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      redirect_to @user , :notice => "User created successfully."
    else
      render 'new', :alert => "Unable to create User!"
    end
  end

  def edit
   authorize @user
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to @user , :notice => "User updated successfully."
    else
      render 'edit', :alert => "Unable to update User!"
    end
  end

  def destroy
    authorize @user
    users_email = @user.email
    if @user.id != current_user.id && @user.destroy
      redirect_to users_path , :notice => "User deleted successfully."
    else
      redirect_to users_path, :alert => "Unable to delete the user please check with Adminstrator"
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin, :role)
  end

  def skip_password
    @user.skip_password_validation = true if current_user.role.admin?
  end
end
