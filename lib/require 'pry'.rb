require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri' 
require 'open-uri'

puts "Wait a second data is coming..."

PAGE_URL = "https://coinmarketcap.com/all/views/all/"
page = Nokogiri::HTML(open(PAGE_URL))

# From the website, get an array of the currencies name and convert it to string
currency_name_array = page.xpath("//tr/td/a[contains(@class, 'currency-name-container')]/text()").map {|x| x.to_s }
# From the website, get an array of the currencies price and convert it to string
currency_value_array = page.xpath("//tr/td/a[contains(@class, 'price')]/text()").map {|x| x.to_s }

# Convert the 2 arrays into hash
currency_result = Hash[currency_name_array.zip(currency_value_array)]

puts currency_result