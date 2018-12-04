class UsersController < ApplicationController
  include SessionsHelper
  before_action :set_user, except: [:index, :new, :create, :show_public, :index_json, :search, :search_resp]
  before_action :logged_in, only: [:show, :search]
  before_action :correct_user, only: :show

  def new
    @user=User.new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      flash= {:danger => '该用户已存在'}
    else
      user = User.new
      user.name = params[:name]
      user.email = params[:email]
      user.password_digest = params[:password]
      curr_datetime = Time.now
      user.created_at = curr_datetime
      user.updated_at = curr_datetime
      user.save
      puts user.errors.full_messages
      flash= {:info => '注册成功，请重新登录'}
    end
    redirect_to root_url, :flash => flash
  end

  # user use this to see his own profile
  def show
  end

  # show a user's public avaible info
  def show_public
    user = User.find_by(id: params[:id])
    if user
      @user = user
    else
      flash= {:info => '该用户不存在'}
      redirect_to root_url, :flash => flash
    end
  end

  def search
  end

  def search_resp
    @match_users = User.where(name: params[:name])
    if @match_users == nil
      flash= {:info => '找不到此用户'}
      redirect_to "users/search", :flash => flash
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to user_path(current_user), flash: flash
  end

  def delete
    @user.destroy
    redirect_to root_url, flash: {success: "用户删除"}
  end

  private

  def user_params
    params.require(:user).permit(:name, :password_digest, :sex, :phonenumber)
  end

  # Confirms a logged-in user.
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def correct_user
    unless current_user == @user
      redirect_to user_path(current_user), flash: {:danger => '您没有权限浏览他人信息'}
    end
  end

  def set_user
    @user=User.find_by_id(params[:id])
    if @user.nil?
      redirect_to root_path, flash: {:danger => '没有找到此用户'}
    end
  end

end
