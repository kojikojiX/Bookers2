class UsersController < ApplicationController
	before_action :authenticate_user!
	def index
	  	@user = User.find(current_user.id)
	  	@users = User.all
	  	@book = Book.new
	end

	def show
	  	@user = User.find(params[:id])
	  	@book = Book.new
	  	@books = @user.books
	end

	def edit
	    @user = User.find(params[:id])
	    if @user.id != current_user.id
            redirect_to user_path(current_user.id)
        end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		   flash[:notice] = "You have creatad book successfully."
		   redirect_to user_path(@user.id)
	    else
	    	render :edit
	    end
	end

	private
    def user_params
    	params.require(:user).permit(:name, :profile_image, :introduction)
    end
end