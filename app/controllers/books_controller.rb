class BooksController < ApplicationController
    before_action :authenticate_user!
    def new
    	@book = Book.new
    end
    def create
    	@book =Book.new(book_params)
        @book.user_id = current_user.id
    	if @book.save
            flash[:notice] = "You have creatad book successfully."
    		redirect_to book_path(@book.id)
    	else
            @user = current_user
            @books = Book.all
    		render:index
    	end
    end
    def index
        @user = current_user
        @book =Book.new
        @books = Book.all
    end
    def show
        @postbook =Book.new
        @book = Book.find(params[:id])
        @user = @book.user

    end
    def edit
        @book =Book.find(params[:id])
        if @book.user.id != current_user.id
            redirect_to books_path
        end
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:notice] = "You have updated book successfully."
            redirect_to book_path(@book.id)
        else
            render:edit
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end
    private

    def book_params
    	params.require(:book).permit(:title, :body, :user_id)
    end
end
