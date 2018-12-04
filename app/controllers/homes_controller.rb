class HomesController < ApplicationController
  def home
    # dump all records, making it easier to debug
    puts "\n\n"
    puts "********"
    puts "All users:"
    User.all.each do |user|
      puts user
    end

    puts "********\n\n"
    puts "All friend applications:"
    FriendApplication.all.each do |f|
      puts f
    end
    puts "********\n\n"

    puts "********\n\n"
    puts "All friends:"
    Friendship.all.each do |f|
      puts f
    end
    puts "********\n\n"

    puts "********\n\n"
    puts "All chats:"
    Chat.all.each do |f|
      puts f
    end
    puts "********\n\n"

    puts "********\n\n"
    puts "All messages:"
    Message.all.each do |f|
      puts f
    end
    puts "********\n\n"

=begin
    User.all.each do |user|
      user.destroy
    end
    Chat.all.each do |user|
      user.destroy
    end
    FriendApplication.all.each do |user|
      user.destroy
    end
    Friendship.all.each do |user|
      user.destroy
    end
    Message.all.each do |user|
      user.destroy
    end
=end
  end
  def login
  end
  def register
  end
end
