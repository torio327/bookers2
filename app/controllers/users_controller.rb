class UsersController < ApplicationController

  def index
    @user=User.find(current_user.id)
    @book=Book.new
    @users=User.all
    
  end

  def update
    @user=User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)

  end

  def edit
    @user=User.find(current_user.id)
    
    
  end

  def show
    @user=User.find(current_user.id)
    @books=Book.where(:user_id=>@user.id)
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    @book.save
    if @book.save
      redirect_to book_path(@book.id)
    else
      render books_path
    end

  end


  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end
end
