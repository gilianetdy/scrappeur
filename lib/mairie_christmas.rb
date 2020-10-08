require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri' 
require 'open-uri'

puts "Mairie du Val d'Oise, here we go..."


#1 Première méthode : Récupération de l'email d'une mairie d'une ville du Val d'Oise
def get_townhall_email(townhall_url)
	page = Nokogiri::HTML(URI.open(townhall_url)) #/ on indique un site URL neutre qui sera indiqué dans la prochaine méthode
	email_array = []

	email = page.xpath('//*[contains(text(), "@")]').text
	town = page.xpath('//*[contains(text(), "Adresse mairie de")]').text.split #/ on divise la string pour pouvoir récupérer uniquement le nom de la ville

	email_array << {town[3] => email} #/ on indique la position du nom de la ville dans la string pour la récupérer
	puts email_array
	return email_array
end

#2 Deuxième méthode : Récupération des URLs des villes du Val d'Oise
def get_townhall_urls
	page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
	url_array = []

	urls = page.xpath('//*[@class="lientxt"]/@href') #/ toutes les URLs appartiennent à la classe lientxt

	urls.each do |url| #/ pour chaque URLs récupérées, il faut leur indiquer l'url parent "http://annuaire-des-mairies.com"
		url = "http://annuaire-des-mairies.com" + url.text[1..-1] #/ A l'url parent, on ajoute les urls récupérées du deuxième caractère au dernier caractère, car on veut se débarasser du point devant.
		url_array << url		
	end
	return url_array 
end

#3 Troisième méthode : Synchronisation des noms des villes et des emails des mairies
def town_mail
	url_array = get_townhall_urls 
	    url_array.each do |townhall_url| #/ pour chaque URL d'une ville du Val d'Oise, on associe l'adresse mail de la mairie
	get_townhall_email(townhall_url)
	end
end 


town_mail