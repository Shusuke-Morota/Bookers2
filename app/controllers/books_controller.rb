class BooksController < ApplicationController

	def new
		@book = Book.new
		@user = User.find(params[:id])
	end

	def create
		@book = Book.new(user_params)
		@book.user_id = current_user.id
		@book.save
		redirect_to book_path(@book.id)
		if @book.save
			flash[:notice] = "You have creatad book successfully."
			redirect_to books_path
		else
			flash.now[:alert] = "error"
			render :index
		end
	end

	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end

	def show
		@book = Book.find(params[:id])
		@book = Book.new
		@user = current_user
	end

	def edit
		@book = Book.user_id
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path #本一覧に戻ります
	end

	def update
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	private
	def user_params
		params.require(:book).permit(:title, :body)
	end
end
