require_relative 'scrap_wine'

# w = fetch_wines_urls(2)
# p w

#url = 'https://www.wineandco.com/xavier-vignon-cotes-du-rhone-villages-bio-2019-45908-fr-eur-fr.html'
#url = 'https://www.wineandco.com/champagne-pierson-cuvelier-grand-cru-cuvee-prestige-49904-fr-eur-fr.html'
url = "https://www.wineandco.com/chateau-grand-corbin-despagne-2015-15500-fr-eur-fr.html"
#url = "https://www.wineandco.com/champagne-lanson-le-rose-39315-fr-eur-fr.html"
url_img = "https://myimg.com/mimg.jpeg"
price = "12.60"

# res = ScrapWine.new.scrape_wine_page(url, price, url_img)
# p res
# v = Wine.new(res)
# puts v.valid?


 notes = ["93/100", "17/20", "93/100", "91-92/100", "94/100", "91/100", "90/100", "78.75/20", "16/20"]
 note_final = ScrapWine.new.rating_average(notes)
 p note_final
