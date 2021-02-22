class PrototypesController < ApplicationController
  before_action :authenticate_user!, except:[:index,:show]

  def index
    @prototypes = Prototype.all
      # binding.pry
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params) 
    # binding.pry
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    # binding.pry
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    # binding.pry
    unless @prototype.user_id == current_user.id
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      # binding.pry
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title,:catch_copy,:concept,:image)
    .merge(user_id: current_user.id)
  end

 
end
