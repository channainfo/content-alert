class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(20)
  end

  def new
    @user = User.new
  end

  def list
    @users = User.from_query(params[:q])
    shared_user_ids = current_user.shared.ids + [current_user.id]

    @users  = @users.excludes(shared_user_ids)
    render json: @users
  end

  def create
    @user = User.new(filter_params)
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if(@user.save)
      redirect_to  users_path, notice: 'User has been created successfully'
    else
      flash.now[:alert] = 'Failed to save user'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(filter_params)
      redirect_to users_path, notice: 'User has been updated successfully'
    else
      flash.now[:alert] = 'Failed to update user'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.is_admin? && @user.destroy
      redirect_to users_path, notice: 'User has been deleted'
    else
      redirect_to users_path, alert: 'Failed to remove users'
    end
  end

  def reset
    @user = User.find(params[:id])
    @random_password =  RandomWord.child_word_from_file("#{Rails.root}/public/ref/words.txt")
    @user.password = @random_password

    if !@user.save
      redirect_to edit_user_path(@user), alert: "Failed to reset password for this user. Please try again"
    end
  end

  def profile
    @user = current_user
  end

  def update_profile
    update_params = params.require(:user).permit(:full_name, :email, :phone)
    @user = User.find(current_user.id)

    if @user.update_attributes(update_params)
      redirect_to profile_users_path, notice: 'Profile has been updated'
    else
      flash.now.alert = 'Failed to update your profile'
      render :profile
    end
  end

  def password
    @user = current_user
  end

  def update_password
    old_password = params[:user][:old_password]
    password = params[:user][:password]
    password_confirmation = params[:user][:password_confirmation]
    @user = User.find(current_user.id)

    if @user.change_password(old_password, password, password_confirmation)
      redirect_to password_users_path, notice: 'Your password has been changed successfully'
    else
      flash.now.alert = 'Failed to update your password'
      render :password
    end
  end

  private

  def filter_params
    params.require(:user).permit(:full_name, :email, :phone, :role)
  end


end