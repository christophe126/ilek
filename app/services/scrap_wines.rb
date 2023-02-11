# frozen_string_literal: true

# https://www.wineandco.com/search?pageNumber=1&filters[color][5]=5&filters[note][bettane]=bettane&filters[note][decanter]=decanter&filters[note][rvf]=rvf&filters[note][parker]=parker&filters[note][winespec]=winespec

require 'open-uri'
require 'nokogiri'
require 'uri'

USER_AGENT    = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36'
URL           = 'https://www.wineandco.com/search?'
FILTER_PAGE   = 'pageNumber='
# FILTER_COLOR  = '&filters[color][6]=6&filters[color][10]=10&filters[color][5]=5&filters[color][1]=1'
# filtre Rosé
FILTER_COLOR  = '&filters[color][5]=5'
FILTER_NOTES  = '&filters[note][bettane]=bettane&filters[note][decanter]=decanter&filters[note][rvf]=rvf&filters[note][parker]=parker&filters[note][winespec]=winespec'
def url_document(page_number = 1)
  main_url = "#{URL}#{FILTER_PAGE}#{page_number}#{FILTER_COLOR}#{FILTER_NOTES}"
  Nokogiri::HTML.parse(URI.parse(main_url).open('Accept-Language' => 'en-US', 'User-Agent' => USER_AGENT).read)
end

def fetch_number_of_results
  doc = url_document
  doc.search('.product-list-product-count').text.to_i
end

def fetch_wines_urls(page)
  doc = url_document(page)
  wines = doc.search('.product-list-products.c-products__wrapper > div > div > a')
  results = []
  wines.each do |wine|
    price = wine.search('span.price').text.split[0]
    uri = URI.parse(wine.attributes['href'].value)
    uri.scheme = 'https'
    uri.host = 'www.wineandco.com'
    uri.query = nil
    uri.to_s
    results << [uri, price]
  end
  results
end

def scrape_wine_page(values)
  p "-----------------#{values}-----------"
  url = values[0]
  p url

  doc = Nokogiri::HTML.parse(URI.parse(url).open("Accept-Language" => "en-US", "User-Agent" => USER_AGENT).read)

  # if Expert review
  unless doc.search('c-product-notations__experts__wrapper').nil?

    notes_avis_expert = []
    doc.search('.c-product-notations__experts__item').each do |element|
      notes_avis_expert << element.search('.c-product-notation-expert__note').text
    end

    # Wine Description
    wine_description = []
    doc.search('.l-product__description .c-product-description p').each do |element|
      wine_description << element.text
    end

    # Output Hash for wine
    {
      ref_id: url.split('-')[-4].to_i,
      name: doc.search('h1').text.strip,
      price: values[1],
      available: doc.search('.stock').last.text,
      domaine: doc.search('.c-product-characteristics__text')[0].text,
      country: doc.search('.c-product-characteristics__text')[1].text,
      location: doc.search('.c-product-characteristics__text')[2].text,
      color: doc.search('.c-product-characteristics__text')[3].text,
      year: doc.search('.c-product-characteristics__text')[4].text,
      appellation: doc.search('.c-product-characteristics__text')[5].text,
      wine_description: wine_description,
      notes_avis_expert: notes_avis_expert
    }
  end
end
