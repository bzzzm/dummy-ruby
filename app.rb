#encoding: utf-8
require 'sinatra'
require 'erb'
require 'json'
require 'pdfkit'

# index
get '/' do
    erb :index
end

get '/formulare' do
    erb :formulare
end

get '/contact' do
    erb :contact
end

post '/callback' do
    content_type 'application/pdf'

    erb_file = 'views/ty.erb'

    html = ERB.new(File.read(erb_file)).result(OpenStruct.new({'data' => params}).instance_eval { binding }) 
    kit = PDFKit.new(html, :page_size => 'Letter')

    return kit.to_pdf

    # return html
end

get '/test_callback' do
    content_type 'application/pdf'
    json = JSON.parse('[{"value": "Popescu","type":"text","required":true,"label":"Nume","subtype":"text","name":"nume","className":"Cnp"},{"type":"text","required":true,"label":"Prenume","subtype":"text","name":"prenume","value":"Ion","className":"Cnp"}]')
    data = {}
    json.each do |d|
        data[d['name']] = {
            'value' => d['value'],
            'label' => d['label']
        }
    end
    p data
    erb_file = 'views/ty.erb'

    html = ERB.new(File.read(erb_file)).result(OpenStruct.new({'data' => data}).instance_eval { binding }) 
    kit = PDFKit.new(html, :page_size => 'Letter')

    # kit.stylesheets << 'public/bootstrap.css'
    # return html
    return kit.to_pdf
end