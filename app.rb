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
    data = JSON.parse(request.body.read.to_s)
    erb_file = 'views/ty.erb'

    html = ERB.new(File.read(erb_file)).result(OpenStruct.new({'data' => data}).instance_eval { binding }) 
    kit = PDFKit.new(html, :page_size => 'Letter')

    # kit.stylesheets << 'public/bootstrap.css'
    # return html
    return kit.to_pdf

    # data = JSON.parse(request.body.read.to_s)
    # erb :ty, :locals => { :data => data }
end

get '/callback' do
    content_type 'application/pdf'
    data = JSON.parse('[{"value": "cucu","type":"text","required":true,"label":"Nume","subtype":"text","name":"nume","className":"Cnp"},{"type":"text","required":true,"label":"Prenume","subtype":"text","name":"text-1476014729454","value":"test","className":"Cnp"}]')
    erb_file = 'views/ty.erb'

    html = ERB.new(File.read(erb_file)).result(OpenStruct.new({'data' => data}).instance_eval { binding }) 
    kit = PDFKit.new(html, :page_size => 'Letter')

    # kit.stylesheets << 'public/bootstrap.css'
    # return html
    return kit.to_pdf
end