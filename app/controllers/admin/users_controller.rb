class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  
  def index
    @users = policy_scope(User)
  end
  
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to root_path, notice: "Admin criado com sucesso"
    else
        render :new
    end
  end  

  private

  def require_admin
    redirect_to root_path, alert: "Ação negada." unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin)
  end
end