class SessionController < ApplicationController
	def create
		redirect_to session_show_path if session[:user_id]

		if request.get?
			@user = User.new
		else
			puts user_params
			@user = User.new(user_params)
			if @user.save
				redirect_to session_check_path
			# else
			# 	redirect_to session_create_path
			end
		end
	end

	def check
		if request.get?
			@user = User.new
		else
			@user = User.find_by_email(user_params[:email]).try(:authenticate, user_params[:password]) 
			if @user
				puts "Authenticated"
				session[:user_id] = @user.id
				redirect_to session_show_path
			else
				@user = User.new(user_params)
				@user.errors.add(:Email, "and/or password don't match")
				puts "Try again"
			end
		end
	end

	def show
		@user = User.find(session[:user_id])
	end

	def destroy
		reset_session
		redirect_to session_create_path
	end

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_digest)
	end
end
