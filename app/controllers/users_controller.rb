class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all.order("email")
  end

  def show
    @user = User.find(params[:id])
#    UserMailer.send_welcome_email(@user).deliver_now
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
        flash[:notice] = "User Killed"
        redirect_to users_path
    else
        flash[:error] = "User Deletion Failed"
        redirect_to users_path
    end
  end
  
  def set_role
    @user = User.find(params[:user_id])
    set_user_role(@user,params[:role])
    if @user.save!
      flash[:notice] = "Role Saved"
      redirect_to user_path(@user)
    else
      flash[:error] = "Role Error"
      redirect_to user_path(@user)
    end
  end

  def password_reset_instructions
    #reset password for a user_id and send email
    @user = User.find(params[:user_id])
    @user.send_reset_password_instructions
    redirect_to user_path(@user)
  end

  private
    def user_params
      params.require(:user).permit(:name, :admin_role, :supervisor_role, :sales_role, :user_role)
    end
    
    def set_user_role(user,role)
      user.admin_role = false
      user.supervisor_role = false
      user.sales_role = false
      user.user_role = false
      case
      when role == 'admin'
        user.admin_role = 1
      when role == 'supervisor'
        user.supervisor_role = 1
      when role == 'sales'
        user.sales_role = 1
      else
        user.user_role = 1
      end
    end
end
