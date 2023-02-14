require 'open-uri'
require 'nokogiri'
require 'uri'

class ScrapWine
 # https://www.wineandco.com/search?pageNumber=1&filters[color][5]=5&filters[note][bettane]=bettane&filters[note][decanter]=decanter&filters[note][rvf]=rvf&filters[note][parker]=parker&filters[note][winespec]=winespec

  USER_AGENT    = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36'
  URL           = 'https://www.wineandco.com/search?'
  FILTER_PAGE   = 'pageNumber='
  # FILTER_COLOR  = '&filters[color][6]=6&filters[color][10]=10&filters[color][5]=5&filters[color][1]=1'
  # filtre Rosé
  FILTER_COLOR  = '&filters[color][6]=6'
  FILTER_NOTES  = '&filters[note][bettane]=bettane&filters[note][decanter]=decanter&filters[note][rvf]=rvf&filters[note][parker]=parker&filters[note][winespec]=winespec'

  def url_document(page_number = 1)
    main_url = "#{URL}#{FILTER_PAGE}#{page_number}#{FILTER_COLOR}#{FILTER_NOTES}"
    Nokogiri::HTML.parse(URI.parse(main_url).open('Accept-Language' => 'fr-FR', 'User-Agent' => USER_AGENT).read)
  end

  def fetch_number_of_results
    doc = url_document
    doc.search('.product-list-product-count').text.to_i
  end

  def fetch_wines_urls(page)
    doc = url_document(page)
    wines = doc.search('.product-list-products.c-products__wrapper > div > div > a')
    array_with_url_price = []
    wines.each do |wine|
      price = wine.search('span.price').text.split[0]
      uri = URI.parse(wine.attributes['href'].value)
      img_small = wine.search('div > div > img')[0].attributes['src'].value
      array_with_url_price << [uri.to_s, price, img_small]
    end
    array_with_url_price
  end

  def scrape_wine_page(url, price, img_small)
    unless price.nil?

      doc = Nokogiri::HTML.parse(URI.parse(url).open('Accept-Language' => 'fr-FR', 'User-Agent' => USER_AGENT).read)
      # if Expert review
      unless doc.search('c-product-notations__experts__wrapper').nil?
        output = {}

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
        output['sku_id'.to_sym] = url.split('-')[-4].to_i
        output['name'.to_sym] = doc.search('h1').text.strip
        output['price'.to_sym] = price.to_i
        output['available'.to_sym] = doc.search('.stock').last.text
        output['wine_description'.to_sym] = wine_description.to_s
        output['rating'.to_sym] = rating_average(notes_avis_expert)
        #output['rating'.to_sym] = notes_avis_expert
        output['wine_url'.to_sym] = url
        output['wine_img'.to_sym] = "https://static2.wineandco.com/themes/wineandco/images/produits/#{url.split('-')[-4].chars.join('/')[0...-1]}grd#{url.split('-')[-4]}.jpg"
        output['wine_img_small'.to_sym] = img_small
        # Wine characteristic
        doc.search('div.l-product__characteristics > div > div > div').each do |elements|
          elements.search('li').each do |element|
            label = element.search('p span.c-product-characteristics__label').first.text.strip
            val = element.search('p span.c-product-characteristics__text').last.text.strip
            output[remove_accents(label)] = val
          end
        end
        output
      end
    end
  end

  def rating_average(notes)
    # ["16/20", "92/100", "89/100", "92/100", "92/100"]
    # ["93/100", "17/20", "93/100", "91-92/100", "94/100", "91/100", "90/100", "78.75/20", "16/20"]
    nb_notes = notes.count
    n = 0
    notes.each do |note|
      if note.split('/')[1][0..1].to_i != 100
        n += (note.split('/')[0].to_i * 100) / note.split('/')[1].to_i
      else
        n += note.split('/')[0].to_i
      end
    end
    n / nb_notes
  end

  def remove_accents(str)
    accents = {
      ['á','à','â','ä','ã','Ã','Ä','Â','À'] => 'a',
      ['é','è','ê','ë','Ë','É','È','Ê'] => 'e',
      ['í','ì','î','ï','Î','Ì'] => 'i',
      ['ó','ò','ô','ö','õ','Õ','Ö','Ô','Ò','Ó'] => 'o',
      ['ú','ù','û','ü','Ú','Û','Ù','Ü'] => 'u',
      ['ç','Ç'] => 'c',
      ['ñ','Ñ'] => 'n'
    }
    accents.each do |ac, rep|
      ac.each do |s|
        str = str.gsub(s, rep)
      end
    end
    str = str.gsub(/[^a-zA-Z0-9\. ]/,"")
    str = str.gsub(/[ ]+/," ")
    str = str.gsub(/ /,"_")
    str = str.downcase
    str = str.to_sym
  end
end
