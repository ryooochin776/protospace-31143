class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]


  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render new_prototype_path
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to prototype_patt(@prototype)
    else
      render edit_prototype_path
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def contributor_confirmation
    unless user_signed_in?
     redirect_to root_path 
    end
  end
end