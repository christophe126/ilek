# frozen_string_literal: true

#----------------- VOIR SEED -------------------

require_relative 'scrap_wines'

RESULT_PER_PAGE = 30

puts "fetching...."
number_of_results = fetch_number_of_results
puts "Number Of Results: #{number_of_results}"

number_of_pages = (number_of_results / RESULT_PER_PAGE) + 1
puts "Number of pages:  #{number_of_pages} found"

puts "How many pages do you want to import? max #{number_of_pages}"
how_much_pages_to_import = gets.chomp.to_i

#unless number_of_pages.zero?
unless how_much_pages_to_import.zero?
  urls_scrap_on_pages = []
  puts 'Fetching Wines URLs'
  (1..number_of_pages).to_a.each do |page|
    urls_scrap_on_pages << fetch_wines_urls(page)
    puts "Urls on Page #{page}/#{number_of_pages} scrapped"
  end

  puts 'Wines scrapping in progress...'

  datas = []
  urls_scrap_on_pages.each do |values|
    values.each do |value|
      datas << scrape_wine_page(value[0], value[1], value[2])
    end
  end
  p datas
  # end
end

puts 'Done.'
