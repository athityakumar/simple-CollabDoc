class AdminController < ApplicationController
	def documents
		@documents = Document.all
		session[:admin] = true
		@user = spoof_admin_user
		session[:user_id] ||= @user.id
	end

	def users
		@users = User.all
		session[:admin] = true
		@user = spoof_admin_user
		session[:user_id] ||= @user.id
	end

	http_basic_authenticate_with name: "admin", password: "hunter2"
end
