# Crawler & parser
require 'open-uri'
require 'nokogiri'

#id = 2


#zlacnene.sk
#(1..56).each do |id|
#  puts "Strana cislo #{id}"
#  html = open("http://www.zlacnene.sk/tovar/hladaj/sk-potraviny/p/#{id}")
#  doc = Nokogiri::HTML(html)
#  doc.search('.zboziVypis').each do |produkt|
#    meno = produkt.search('h2 a').text #.split
#    #meno.sub!(/\d.*/im, "") --> ostranenie gramaze, objemu a pod za nazvom produktu
#    puts meno
#
#
#    cena = produkt.search('.cena').text.split(' ')
#    obchod = produkt.search('.prodejnaName').text
#    platnostDo = produkt.search('.platiDo').text
#    puts cena[1] +" "+obchod +" "+ platnostDo
#
#    puts ""
#
#    end
#end

#itesco - este dorobit stranky priamo v jednotlivych kategoriach
(3..512).each do |id|
  id=id.to_s
  dlzka = id.length
  while (dlzka<8) do
    id = "0"+id
    dlzka +=1
  end

  puts "Strana cislo #{id}"
  html = open("http://potravinydomov.itesco.sk/sk-SK/Product/BrowseProducts?taxonomyId=Cat#{id}")
  doc = Nokogiri::HTML(html, 'UTF-8')
  doc.search('.t.product').each do |produkt|
    meno = produkt.search('h2 a').text
    puts meno

    cena = produkt.search('.price').text.split(' ')
    gibber = produkt.search('h3').text
    puts gibber
    #obchod = "Tesco" #D'uh
    platnostDo = produkt.search('.promoUntil').text
    platnostDo.sub!(/.*?(?=\d)/im, "")
    puts cena[0] +" "+ platnostDo[0..-3] #+" "+obchod  POZN: platnost netreba - denne update-y databazy
    puts ""
  end
end
# subject.save
#  end

# Na stahovanie (HTTP)

#https://github.com/taf2/curb
#https://github.com/toland/patron

# Nokogiri (XML & HTML parser)
#http://nokogiri.org/

# Mechanize
#http://mechanize.rubyforge.org/EXAMPLES_rdoc.html

# Queue
#
# sidekiq
#
# https://github.com/mperham/sidekiq/wiki

#(1.1_300_000).each do |id|
#  Sidekiq.enqueue(ParseDocument, id)
#end

#class ParseDocument
#  def perform(id)
#    html = open("http://www.statistics.sk/pls/wregis/detail?wxidorg=#{id}")
#
#    doc = Nokogiri::HTML(html)
#
#    doc.search('.tabid tr').each do |tr|
#      subject = Subject.new
#      tds = tr.search('td')
#      case tds[0].text
#     when 'IČO:' then subject.ico = tds[0].text
#     when 'Obchodné meno:' then subject.name = tds[2].text
#     end

#      subject.save
#    end
#  end
#end
