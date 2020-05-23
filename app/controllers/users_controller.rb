class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.all
		@user = current_user #ログイン後の自分自身
		@book = Book.new
	end

	def show
        @user = User.find(params[:id])
        @books = @user.books
        @book = Book.new
	end

	def edit
		@user = User.find(params[:id])
	    if @user != current_user
	    	redirect_to user_path(current_user.id)
	    end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		   redirect_to user_path(current_user.id)
		   flash[:notice] = "You have created book successfully."
		else
			render :edit
		end

	end

	private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end

end
