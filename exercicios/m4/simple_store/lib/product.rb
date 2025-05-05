class Product
    attr_reader :title, :price, :manufacturer, :barcode
    attr_accessor :code

    def initialize(hash)
        self.title = (hash['title'])
        self.price = (hash['price'])
        self.manufacturer = (hash['manufacturer_code'])
        self.barcode = (hash['barcode'])
        @code = generate_control_code
    end

    def title= (value) #setter
        fail SimpleStore::Error, "O título do produto não pode ser vazio" if value == nil || value.size == 0

        @title = value
    end

    def price= (value)
        fail SimpleStore::Error, "O preço do produto deve ser >= 0.0" if value == nil || value < 0

        @price = value
    end

    def manufacturer= (value)
        hash = SimpleStore::AUTHORIZED_MANUFACTURERS
        manu = hash.find { |chave, valor| valor == value}

        fail SimpleStore::Error, "O fabricante não está autorizado" if nil == manu

        @manufacturer = manu[0]
    end

    def barcode= (value)
        @barcode = value
    end

    def expiration_date= (value)
        date_today = Date.today
        date_value = Date.parse(value) if value != nil

        fail SimpleStore::Error, 'O produto não pode estar vencido' if date_value == nil || date_value <= date_today

        @expiration_date = value
    end

    private

    def generate_control_code
        puts @class_name
    #código do tipo do produto - código do fornecedor - código de barra
        "#{SimpleStore::PRODUCT_TYPES[self.class.to_s.to_sym]}--#{SimpleStore::AUTHORIZED_MANUFACTURERS[@manufacturer]}--#{@barcode}"
    end
end