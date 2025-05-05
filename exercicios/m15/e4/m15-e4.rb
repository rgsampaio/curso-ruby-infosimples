require 'mechanize' #importa biblioteca mechanize
require 'json' #importa biblioteca json

def tabela_scrape
  agent = Mechanize.new #inicia objeto da classe mechanize 
  agent.get 'https://www.w3schools.com/html/html_tables.asp' #faz requisição GET para o site 
  doc = agent.page.parser #traz uma árvore de elementos html

  result = { 'tabelas' => [] } #cria um hash com chave 'tabelas', e o valor é um array vazio

  doc.css('table').each do |table| #itera sobre todas as tabelas do site
    headers = table.css('tr > th').map(&:text) #pega os cabeçalhos das tabelas

    tabela_dados = {} #cria um hash vazio para armazenar os cabeçalhos

    headers.each { |nome| tabela_dados[nome] = [] } #cada cabeçalho é adicionado como chave no hash, contendo um valor vazio
    
    linhas = table.css('tr') #pega as linhas de cada tabela
    
    linhas.each do |linha_dados| #extrai o texto das células de cada linha (células são as colunas de dados, representadas por td)
      celulas = linha_dados.css('td').map(&:text) ##extrai o texto das células de cada linha (células são as colunas de dados, representadas por td)
      celulas.each_with_index do |valor, index| #para cada celula, adiciona o valor no array da coluna correspondente ao hash
        nome_coluna = headers[index] 
        tabela_dados[nome_coluna] << valor
      end
    end

    result['tabelas'] << tabela_dados #adiciona os dados na tabela final
  end

  json_data = JSON.pretty_generate(result) #gera um arquivo JSON de maneira formatada e bonita para salvar os dados
  File.write('result.json', json_data, mode: 'w') #salva o JSON como arquivo 'result.json'
end