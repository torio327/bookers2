class BooksController < ApplicationController
  def new
  end

  def show
    # @user=User.find(current_user.id)
    @book_detail=Book.find(params[:id])
    @user=User.find(@book_detail.user_id)
    @book=Book.new
  end

  def index
    @user=User.find(current_user.id)
    @books=Book.all
    @book=Book.new
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def edit
    @book=Book.find(params[:id])
    unless current_user.id==@book.user_id
      redirect_to books_path
    end    
  end

  def update
    @book=Book.find(params[:id])
    @book.update(book_params)
    @book.save
    if @book.save
      flash[:notice]="You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    @book.save
    @user=User.find(current_user.id)
    if @book.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books=Book.all
      render :index
    end
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end
