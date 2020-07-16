# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'open-uri'

def open_page(page_url)
  # Open HTML page
  Nokogiri::HTML(URI.open(page_url))
end

def select_target_css(page, css_selector)
  result_array = []

  # Select classes to be scrapped
  page.css(css_selector).each do |link|
    result_array << link['href']
  end

  result_array
end

def select_target_xpath(page, xpath)
  result_array = []

  # Select xpath to be scrapped
  page.xpath(xpath).each do |link|
    result_array << link.text
  end

  result_array
end

def email_scraper
  city_array     = []
  email_array    = []
  email_scraper  = Hash.new

  url_page_array = open_page('http://annuaire-des-mairies.com/val-d-oise.html')
  url_array      = select_target_css(url_page_array, 'a.lientxt')

  # For each URL opens the page and selects the email
  url_array.each do |url|
    url = url.gsub!('./', '')

    mail_page = open_page("http://annuaire-des-mairies.com/#{url}")

    city = select_target_xpath(mail_page, '/html/body/div[1]/main/section[1]/div/div/div/h1')
    city = city.first.split(' ')

    city_array << city.first

    email_array << select_target_xpath(mail_page, '/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]')

  end

  email_scraper = city_array.zip(email_array).to_h
end

puts email_scraper
