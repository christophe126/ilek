require_relative 'scrap_wines'

#url = 'https://www.wineandco.com/xavier-vignon-cotes-du-rhone-villages-bio-2019-45908-fr-eur-fr.html'
#url = 'https://www.wineandco.com/champagne-pierson-cuvelier-grand-cru-cuvee-prestige-49904-fr-eur-fr.html'
url = "https://www.wineandco.com/champagne-laurent-perrier-la-cuvee-brut-sous-etui-17890-fr-eur-fr.html"
price = "10.00"

res = scrape_wine_page(url, price)

p res
