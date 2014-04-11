require 'open-uri'
require 'nokogiri'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
#zlacnene.sk
    (1..56).each do |id|
      #puts "Strana cislo #{id}"
      html = open("http://www.zlacnene.sk/tovar/hladaj/sk-potraviny/p/#{id}")
      doc = Nokogiri::HTML(html)
      doc.search('.zboziVypis').each do |produkt|
        meno = produkt.search('h2 a').text
        #puts meno
        cena = produkt.search('.cena').text.split(' ')
        obchod = produkt.search('.prodejnaName').text
        #platnostDo = produkt.search('.platiDo').text
       # puts cena[1] +" "+obchod +" "+ platnostDo

        item = Product.find_by(name: meno)
        if item.nil? then
          item = Product.create(name: meno)
          item.prices.create!(price: cena, shop: obchod)
        else
          item.prices.create!(price: cena, shop: obchod)
        end

      end
    end
  end
end