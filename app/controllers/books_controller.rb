class BooksController < ApplicationController
	before_action :authenticate_user!

	def new
		@book = Book.new
		@user = User.find(params[:id])
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id

		if @book.save
			flash[:notice] = "You have created book successfully."
		 	redirect_to book_path(@book)
		else
			flash.now[:notice] = "error"
			@books = Book.all
			@user = current_user
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
		@new_book = Book.new
		@user = current_user
	end

	def edit
		@book = Book.find(params[:id])
		if current_user.id != @book.user_id
			redirect_to books_path
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path #本一覧に戻ります
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
		   redirect_to book_path(@book.id)
		   flash[:notice] = "You have created book successfully."
        else
           flash.now[:notice] = "error"
           render :edit
        end
	end

	private
	def book_params
		params.require(:book).permit(:title, :body, :user_id)
	end
end
