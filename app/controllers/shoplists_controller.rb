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
      redirect_to shoplist_products_path(@shoplist.id)
    else
      render 'new'
    end
  end

  def show
    @shoplist = Shoplist.find(params[:id])
    @products = @shoplist.products


    products = @shoplist.products #.paginate(page: params[:page])
    shops = ["Billa", "Carrefour", "Kaufland", "Lidl", "Tesco"]
#map it shops na ceny + vyratat average
#vo view uz len preiterovat

    @ordProducts = Hash.new
    products.each do |product|      #pre kazdy produkt
      prices = product.prices       #get jeho zname ceny

      ordPrices = ActiveSupport::OrderedHash.new   #vytvor ciast. objekt na vopchatie usortenych cien/shop

      (0..4).each do |index|        #prejdi vsetky shopy
        done = false
        sum = 0
        prices.each do |price|      #prejdi vsetky ceny a najdi taku s akt. shopom
          sum += price.price
          if(price.shop.to_s == shops[index])
            done = true
            ordPrices[price.shop] = price.price#daj do OrderedHash
          end
        end
        if(!done)
          if(prices.length==0)
            ordPrices[shops[index]] = "-"
          else
            cena = sum/prices.length #ak nie je v db, daj tam avg vsetkych
            ordPrices[shops[index]] = sprintf('%.2f', cena)
          end
        end
      end
      @ordProducts[product.name] = ordPrices
    end
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
