require 'mechanize'
require 'pry'

#cria um objeto da classe Mechanize
agent = Mechanize.new


#usado para 'enganar' o site, para que ele pense que quem está fazendo o request é um navegador real
agent.request_headers = {
  'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36'
}

#faz requisição HTTP GET à página das últimas notícias do site UOL
agent.get 'https://noticias.uol.com.br/ultimas'

#retorna um objeto Nokogiri com o HTML da página, permitindo manipular o DOM
doc = agent.page.parser #page = object que tem alguns atributos, são eles: .parser e .body 

#procura todos os elementos da página que tem a classe 'thumb-caption' e retorna em um array.
doc.css('.thumb-caption').each do |element|
  binding.pry
  
  #imprimi o texto puro, sem as tags HTML
  puts element.text
end