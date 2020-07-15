# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = 'https://coinmarketcap.com/all/views/all/'

# Opens HTML page
page = Nokogiri::HTML(URI.open(PAGE_URL))

devise_array = []
price_array  = []

# Select classes to be scrapped
page.css('.cmc-table__cell--sort-by__name a').each do |link|
  devise_array << link.text # Crypto name
end

page.css('.cmc-table__cell--sort-by__price a').each do |link|
  price_array << link.text # Crypto price
end

# Zip 2 tables in a Hash
print Hash[devise_array.zip(price_array)]
