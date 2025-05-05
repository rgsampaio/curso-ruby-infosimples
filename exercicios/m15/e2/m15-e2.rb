require 'mechanize' #importando a biblioteca mechanize
require 'json' #importa a biblioteca json para converter um array em arquivo json

agent = Mechanize.new #cria um objeto da classe Mechanize

agent.get 'https://books.toscrape.com/' #faz um request HTTP GET para a página em formato de texto (string)

doc = agent.page.parser #traz uma árvore de elementos do HTML, na qual são os objetos do Nokogiri

array = [] #cria um array vazio para armazenar o hash posteriormente

star_rating = {
    "One" => 1,
    "Two" => 2,
    "Three" => 3,
    "Four" => 4,
    "Five" => 5,
}

doc.css('.col-xs-6').each do |book|
    name = book.css('.product_pod > h3 > a').text
    price = book.css('.price_color').text
    star = book.at_css('.star-rating')
    star_count = star_rating.find { |k, _| star.attr('class').match?(k)}[1] 
    url = book.css('.product_pod > .image_container > a > .thumbnail').attr('src').text
    hash = {
        title: name,
        price: price,
        star: star_count,
        url: "https://books.toscrape.com/#{url}"
    }
    
    array << hash #coloca o hash dentro do array
end

puts array.inspect

#conversão do array para json
json_data = JSON.pretty_generate(array)

File.write('array.json', json_data, mode: 'w')