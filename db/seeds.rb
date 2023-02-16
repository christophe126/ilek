RESULT_PER_PAGE = 30

puts 'fetching....'

number_of_results = ScrapWine.new.fetch_number_of_results
puts "Number Of Results: #{number_of_results}"

number_of_pages = (number_of_results / RESULT_PER_PAGE) + 1
puts "Number of pages:  #{number_of_pages}"

unless number_of_pages.zero?
  urls_scrap_on_pages = []
  puts 'Fetching Wines URLs'
  # (1..number_of_pages).to_a.each do |page|
  # 2 page by default
  (1..2).to_a.each do |page|
    urls_scrap_on_pages << ScrapWine.new.fetch_wines_urls(page)
    puts "Urls on Page #{page}/#{number_of_pages} scrapped"
  end

  puts 'Wines scrapping in progress...'
  datas = []
  count = 0
  urls_scrap_on_pages.each do |values|
    values.each do |value|
      datas << ScrapWine.new.scrape_wine_page(value[0], value[1], value[2])
      p count += 1
    end
  end

  puts 'inserting datas in db progress...'
  datas.each_with_index do |data, index|
    i = Wine.new(data)
    i.valid? ? i.save : "Wine: #{i.sku_id} not saved"
    puts "#{index+1}/#{datas.count} : #{i.name} " if i.valid?
  end
end

puts 'Done.'
