class Admin::ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end
  def create
    @item = Item.new
    @item.user_id = current_user.id
    @item.save
    redirect_to admin_items_path
  end

  def show
  end

  def edit
  end
 
 
  private
  

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :image)
  end
end