require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri' 
require 'open-uri'

puts "Data is coming..."

#1 Déclaration de la page à scrapper
def get_page
	page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
	return page
end

#2 Collecte des abbréviations des noms des monnaies
def scrapp_symbols
	page = get_page
	symbols = page.xpath('//*[@id="__next"]/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
	symbols_array = [] # Array pour les stocker
	symbols.each do |symbol| 
		symbols_array << symbol.text #.text pour récupérer le texte et << pour ajouter les valeurs à l'array
	end
    return symbols_array
end

#3 Collecte des cours des monnaies
def scrapp_prices
	page = get_page
	prices = page.xpath('//*[@id="__next"]/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a')
	prices_array = []
	prices.each do |price|
		prices_array << price.content.delete('$,').to_f #.text pour récupérer le texte du second caractère (pas de signe) au dernier - puis pour convertir en float 
	end
    return prices_array
end 

#4 Synchronisation des noms et des cours des monnaies
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