class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])

    if @user.save
      self.current_user = @user
			login_user!
			redirect_to cats_url(@user)
    else
      render :json => @user.errors.full_messages
    end
	end

	def show
		@user = User.find(params[:id])
		render :show
	end

end
