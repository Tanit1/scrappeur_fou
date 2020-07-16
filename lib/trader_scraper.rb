# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'open-uri'

def open_page(page_url)
  # Open HTML page
  Nokogiri::HTML(URI.open(page_url))
end

def select_target_css(page, css_class)
  result_array = []

  # Select classes to be scrapped
  page.css(css_class).each do |link|
    result_array << link.text # Crypto device
  end

  result_array
end

def crypto_scrapper
  scrapping_array = []

  page = open_page('https://coinmarketcap.com/all/views/all/')

  device_array = select_target_css(page, '.cmc-table__cell--sort-by__name a')
  price_array = select_target_css(page, '.cmc-table__cell--sort-by__price a')

  # Browse the Hash to store each crypto in Hash and
  # then insert it into scrapping_array
  Hash[device_array.zip(price_array)].each do |device, price|
    price = price.delete('$').to_f

    scrapping_array << { device => price }
  end

  scrapping_array
end

puts crypto_scrapper
