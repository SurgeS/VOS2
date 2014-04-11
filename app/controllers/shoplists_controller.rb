class ShoplistsController < ApplicationController
  before_action :signed_in_user

  def create
    @shoplist = current_user.shoplists.build(shoplist_params)
    if @shoplist.save
      redirect_to products_path
    else
      redirect_to shoplist_params
    end
  end

  def destroy
  end

  private
  def shoplist_params
    params.require(:shoplist).permit(:name)
  end
end
