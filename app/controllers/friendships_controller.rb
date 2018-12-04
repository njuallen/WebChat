class FriendshipsController < ApplicationController
  include SessionsHelper
  before_action :logged_in

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:info] = "添加好友成功"
      redirect_to chats_path
    else
      flash[:error] = "无法添加好友"
      redirect_to chats_path
    end
  end

  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    @friendship.destroy

    user=User.find_by_id(params[:id])
    current_user.chats.each do |chat|
      if (chat.users-[user, current_user]).blank?
        chat.destroy
      end
    end

    flash[:success] = "删除好友成功"
    redirect_to chats_path
  end

  def my_friendship_request
    user_id = current_user.id
    @my_requests = FriendApplication.where(
      "(user_id == :user_id AND status == '等待处理')",
      {user_id: user_id})
  end

  def my_friendship_grant
    user_id = current_user.id
    @my_grants = FriendApplication.where(
      "(friend_id == :user_id AND status == '等待处理')",
      {user_id: user_id})
  end

  def finished_friendship_requests
    user_id = current_user.id
    friend_id = params[:friend_id]
    @finished_requests = FriendApplication.where(
      "((user_id == :user_id OR friend_id == :user_id)" \
      "AND " \
      "status != '等待处理')",
      {user_id: user_id})
  end

  def request_friendship
    user_id = current_user.id
    friend_id = params[:friend_id]
    request = FriendApplication.where(
      "(user_id == :user_id AND friend_id == :friend_id)" \
      "OR" \
      "(user_id == :friend_id AND friend_id == :user_id)",
      {user_id: user_id, friend_id: friend_id})
    if request.any?
      flash[:info] = "请勿重复申请"
    else
      request = FriendApplication.new
      request.user_id = user_id
      request.friend_id = friend_id
      request.status = "等待处理"
      request.created_at = Time.now
      request.updated_at = Time.now
      if request.save
        flash[:info] = "请求已发送"
      else
        flash[:error] = "无法发送申请"
      end
    end
    redirect_to chats_path
  end

  def grant_friendship
    request = FriendApplication.find_by(id: params[:id])
    decision = params[:decision]
    if decision == "grant"
      request.status = "已同意"

      friendship = Friendship.new
      friendship.user_id = request.user_id
      friendship.friend_id = request.friend_id
      friendship.created_at = Time.now
      friendship.updated_at = Time.now
      friendship.save

      flash[:info] = "已同意"
    else
      request.status = "已拒绝"
      flash[:info] = "已拒绝"
    end
    request.save
    redirect_to chats_path
  end

  private
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end
end
