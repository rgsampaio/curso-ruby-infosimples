require 'mechanize'

class Scraper
    attr_reader :agent

    def initialize
        @agent = Mechanize.new
        
        @agent.request_headers = {
            'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36'
        }

        @agent.get 'https://www.imdb.com/pt/chart/top/'
    end

    def movies
        doc = agent.page.parser

        doc.css('.ipc-title__text').map do |movie|
            puts movie.text
        end
    end

    def search(value)
        term = value.to_s

        form = agent.page.forms.first

        form['q'] = term

        form.submit

        doc = agent.page.parser

        doc.css('.find-title-result > .ipc-metadata-list-summary-item__c > .ipc-metadata-list-summary-item__tc > .ipc-metadata-list-summary-item__t').map do |movie|
            puts movie.text
        end
    end
end