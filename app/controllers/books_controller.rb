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
	end

	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end

	def show
		@book =Book.find(params[:id])
		
	end

	def edit
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_index
	end

	private
	def user_params
		params.require(:book).permit(:title, :body)
	end
end
