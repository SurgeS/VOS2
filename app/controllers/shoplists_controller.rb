class ShoplistsController < ApplicationController
  #before_action :signed_in_user

  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy


  def new
    @shoplist = current_user.shoplists.build if signed_in?
  end

  def index
    @shoplists = current_user.shoplists
  end

  def create
    @shoplist = current_user.shoplists.build(shoplist_params)
    if @shoplist.save
      redirect_to products_path
    else
      redirect_to shoplist_params
    end
  end

  def show
    @shoplist = Shoplist.find(params[:id])
    @products = @shoplist.products.paginate(page: params[:page])
  end

  def destroy
    @shoplist.destroy
    redirect_to shoplists_path
  end

  private
  def shoplist_params
    params.require(:shoplist).permit(:name)
  end

  def correct_user
    @shoplist = current_user.shoplists.find_by(id: params[:id])
    redirect_to shoplists_path if @shoplist.nil?
  end
end