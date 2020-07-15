# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = 'https://coinmarketcap.com/all/views/all/'

# Ouvre la page HTML
page = Nokogiri::HTML(URI.open(PAGE_URL))

devise_array = []
price_array  = []

# Selectionne les classes a scrapper
page.css('.cmc-table__cell--sort-by__name a').each do |link|
  devise_array << link.text # Nom de la crypto
end

page.css('.cmc-table__cell--sort-by__price a').each do |link|
  price_array << link.text # Nom de la crypto
end

# Zip les 2 tableaux dans un Hash
print Hash[devise_array.zip(price_array)]
