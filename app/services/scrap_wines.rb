# frozen_string_literal: true

# https://www.wineandco.com/search?pageNumber=2&filters[color][5]=5&filters[note][bettane]=bettane&filters[note][decanter]=decanter&filters[note][rvf]=rvf&filters[note][parker]=parker&filters[note][winespec]=winespec

require 'open-uri'
require 'nokogiri'
require 'uri'

USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36'

URL           = 'https://www.wineandco.com/search?'
FILTER_PAGE   = 'pageNumber='
# FILTER_COLOR  = '&filters[color][6]=6&filters[color][10]=10&filters[color][5]=5&filters[color][1]=1'
FILTER_COLOR  = '&filters[color][5]=5' # filtre Rosé
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
  wines.map do |wine|
    uri = URI.parse(wine.attributes['href'].value)
    uri.scheme = 'https'
    uri.host = 'www.wineandco.com'
    uri.query = nil
    uri.to_s
  end
end

def scrape_wine_page(url)
  doc = Nokogiri::HTML.parse(URI.parse(url).open('Accept-Language' => 'en-US', 'User-Agent' => USER_AGENT).read)

  name    = doc.search("h1").text.strip
  ref_id  = url.split('-')[-4]
  price   = doc.search(".l-product__infos__price span span").text
  p price
  #year = doc.search(".ipc-link.ipc-link--baseAlt.ipc-link--inherit-color.sc-8c396aa2-1").text.to_i
  #storyline = doc.search(".sc-16ede01-2").text
  #director = doc.search('.ipc-metadata-list__item:contains("Director") a').first.text
  #cast = doc.search('.ipc-metadata-list__item:contains("Stars") a.ipc-metadata-list-item__list-content-item').map { |element| element.text }.uniq

  {
    ref_id: ref_id,
    name: name,
    price: price

  }
end
