require_relative 'scrap_wines'

# w = fetch_wines_urls(2)
# p w

#url = 'https://www.wineandco.com/xavier-vignon-cotes-du-rhone-villages-bio-2019-45908-fr-eur-fr.html'
#url = 'https://www.wineandco.com/champagne-pierson-cuvelier-grand-cru-cuvee-prestige-49904-fr-eur-fr.html'
#url = "https://www.wineandco.com/champagne-laurent-perrier-la-cuvee-brut-sous-etui-17890-fr-eur-fr.html"
url = "https://www.wineandco.com/champagne-lanson-le-rose-39315-fr-eur-fr.html"
url_img = "https://myimg.com/mimg.jpeg"
price = "10.00"

res = scrape_wine_page(url, price, url_img)
p res


# notes = ["16/20", "92/100", "89/100", "92/100", "92/100"]
# note_final = rating_average(notes)
# p note_final
