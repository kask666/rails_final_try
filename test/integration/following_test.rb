require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
	
	def setup 
		@user = users(:kask)
		log_in_as(@user)
	end
	
	test "following page" do
		get following_user_path(@user)
		assert_not @user.following.empty?
		# Sprawdza czy liczba 'following' znajduje się na stronie
		assert_match @user.following.count.to_s, response.body
		# Sprawdza czy linki do wszystkich 'following'-ów znajduja sie na stronie 
		@user.following.each do |user|
			assert_select "a[href=?]", user_path(user)
		end
	end
	
	test "followers page" do
		get followers_user_path(@user)
		assert_not @user.followers.empty?
		assert_match @user.followers.count.to_s, response.body
		@user.followers.each do |user|
			assert_select "a[href=?]", user_path(user)
		end
	end
end
