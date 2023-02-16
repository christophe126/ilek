#
#  File for testing individual methods
#  in 'scrap_wine'
#
require_relative 'scrap_wine'

# w = fetch_wines_urls(2)
# p w

url = 'https://www.wineandco.com/chateau-guiraud-2017-19880-fr-eur-fr.html?btl=375'
# #url = "https://www.wineandco.com/champagne-lanson-le-rose-39315-fr-eur-fr.html"
url_img = 'https://myimg.com/mimg.jpeg'
price = '12.60'

res = ScrapWine.new.scrape_wine_page(url, price, url_img)
p res
# v = Wine.new(res)
# puts v.valid?

#  notes = ["94-95/100", "91-93/100", "90-93/100", "94-96/100", "83.75/20"]
#  note_final = ScrapWine.new.rating_average(notes)
#  p note_final
