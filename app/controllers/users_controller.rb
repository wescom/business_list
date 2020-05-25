class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = ServiceType.find(params[:id])
    if @user.destroy
        flash[:notice] = "User Killed"
        redirect_to users_path
    else
        flash[:error] = "User Deletion Failed"
        redirect_to users_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end
end
