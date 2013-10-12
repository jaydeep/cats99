class SessionsController < ApplicationController
	def create #complete signup
    user = User.find_by_credentials(
    params[:user][:username],
    params[:user][:password]
		)
		unless user.nil?
			login_user!(user)
			redirect_to cats_url
		else
			render :json => "Credentials are invalid"
	  end
	end

  def destroy
		#blank out cookie
		#call reset session token on user

   logout_current_user!
   redirect_to new_session_url
	end

  def new #sends to the signup
		render :new
  end
end
