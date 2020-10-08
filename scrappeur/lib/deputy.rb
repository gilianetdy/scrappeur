require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri' 
require 'open-uri'

puts "Deputy, here it is !"
#1  Déclaration de la page à scrapper
def get_page
	page = Nokogiri::HTML(URI.open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600"))
	return page
end 

#2 Collecte des emails des députés
def scrapp_emails
	page = get_page
    emails = page.xpath('//*[contains(text(), "@assemblee-nationale.fr")]') 
    emails_array = []
	emails.each do |email|
		emails_array << {"emails" => emails.text}
	end
	return emails_array
end

#3 Collecte des noms et prénoms des députés
def scrapp_names
	page = get_page
	full_names_array = []
	full_names = page.xpath('//*[@class="titre_normal"]').each do |the_name| # pas de Mme, Mr
	full_names_array << { "first_name" => the_name.text.split(" ")[1], "last_name" => the_name.text.split(" ")[2]}
	end
	return full_names_array		
end

#4 Synchronisation des noms et emails des députés
def join_name_and_email
	full_names_array = scrapp_names
	emails_array = scrapp_emails
    full_names_array.map.with_index do {|hash, i| hash["email"] = emails_array[i]}
    #/ pour chaque nom et prénom de députés, on associe une adresse mail.
    #/ rajout dans un hash de l'email associé.
    end 
    print full_names_array
    return full_names_array
    
end

join_name_and_email
