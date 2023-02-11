# frozen_string_literal: true

require_relative 'scrap_wines'

RESULT_PER_PAGE = 30

puts "fetching...."
number_of_results = fetch_number_of_results
puts "Number Of Results: #{number_of_results}"

number_of_pages = (number_of_results / RESULT_PER_PAGE) + 1
puts "Number of pages:  #{number_of_pages}"

unless number_of_pages.zero?
  urls_scrap_on_pages = []
  puts 'Fetching Wines URLs'
  (1..number_of_pages).to_a.each do |page|
    urls_scrap_on_pages << fetch_wines_urls(page)
    puts "Urls on Page #{page}/#{number_of_pages} scrapped"
  end
  #urls_scrap_on_pages.flatten!
  puts "#{urls_scrap_on_pages.count / 2} Urls scrapped"

  datas = []
  urls_scrap_on_pages.each do |values|
    values.each do |value|
      datas << scrape_wine_page(value)
    end
  end
  p datas
  # end
end

puts 'Done.'
