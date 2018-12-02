class SessionsController < ApplicationController
  include SessionsHelper

  def create
    user = User.find_by(email: params[:session][:email])
    if user
      puts "find user"
      puts user.password_digest
    else
      puts "user not found"
    end
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
      flash= {:info => "欢迎回来: #{user.name} :)"}
    else
      flash= {:danger => '账号或密码错误'}
    end
    redirect_to root_url, :flash => flash
  end

  def register
    user = User.find_by(email: params[:session][:email])
    if user
      flash= {:danger => '该用户已存在'}
    else
      user = User.new
      user.name = params[:session][:name]
      user.email = params[:session][:email]
      user.password_digest = params[:session][:password]
      curr_datetime = Time.now
      user.created_at = curr_datetime
      user.updated_at = curr_datetime
      user.save
      flash= {:info => '注册成功，请重新登录'}
    end
    redirect_to root_url, :flash => flash
  end

  def new
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
