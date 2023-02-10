# frozen_string_literal: true

require_relative 'scrap_wines'

# RESULT_PER_PAGE = 30

# puts "fetching...."
# number_of_results = fetch_number_of_results
# puts "Number Of Results: #{number_of_results}"

# number_of_pages = (number_of_results / RESULT_PER_PAGE) + 1
# puts "Number of pages:  #{number_of_pages}"

# unless number_of_pages.zero?
#   urls_scrap_on_pages = []
#   puts 'Fetching Wines URLs'
#   # 1..Number_of_pages.each do |page|
#   (1..number_of_pages).to_a.each do |page|
#     urls_scrap_on_pages << fetch_wines_urls(page)
#     puts "#{page}/#{number_of_pages} Wines URLs scrapped"
#   end
#   urls_scrap_on_pages.flatten!
# end

urls_scrap_on_pages = 1
unless urls_scrap_on_pages.zero?
  url = 'https://www.wineandco.com/domaine-la-loyane-cuvee-bonheur-rouge-2021-50164-fr-eur-fr.html'
  res = scrape_wine_page(url)
  p res
end

# p urls_scrap_on_pages
# p urls_scrap_on_pages.count


puts "Done."
