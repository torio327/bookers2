class UsersController < ApplicationController

  def index
    @user=User.find(current_user.id)
    @book=Book.new
    @users=User.all
    
  end

  def update
    @user=User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
    

  end

  def edit
    @user=User.find(params[:id])
    unless @user.id==current_user.id
      redirect_to user_path(current_user.id)
    end    
  end

  def show
    @user=User.find(params[:id])
    @books=Book.where(:user_id=>@user.id)
    @book=Book.new
  end
  
  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end
end
