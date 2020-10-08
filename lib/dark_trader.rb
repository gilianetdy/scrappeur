require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri' 
require 'open-uri'

puts "data is coming..."

#1 Première méthode : Déclaration de la page à scrapper
def get_page
	page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
	return page
end

#2 Deuxième méthode : Collecte des abbréviations des noms des monnaies
def scrapp_symbols
	page = get_page
	symbols = page.xpath('//*[@id="__next"]/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
	symbols_array = [] #/ initialisation d'un array pour les stocker
	symbols.each do |symbol| 
		symbols_array << symbol.text #.text pour avoir les infos en string
	end
    return symbols_array
end

#3 Troisième méthode : Collecte des cours des monnaies
def scrapp_prices
	page = get_page
	prices = page.xpath('//*[@id="__next"]/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a')
	prices_array = []
	prices.each do |price|
		prices_array << price.text[1..-1].to_f
	end
    return prices_array
end 

#4 Quatrième méthode : Synchronisation des noms et des cours des monnaies
def darktrader_master
	symbols_array = scrapp_symbols #/ on rappelle nos méthodes
	prices_array = scrapp_prices 
	a = [] #/ on initialise un array pour les stocker
	symbols_array.each_with_index do |x, y|	#/ on associe pour chaque item de symbols_array un item de prices_array
		a << {x => (prices_array)[y]} #/ on sauvegarde sous forme d'hash dans le tableau
	end
    print a 
	return a
end


darktrader_master