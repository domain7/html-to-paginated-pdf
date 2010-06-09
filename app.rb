require 'rubygems'
require 'sinatra'

get '/' do
  redirect '/html_to_paginated_pdf.html'
end

get '/html_to_paginated_pdf.html' do
  erb :html_to_paginated_pdf
end

get '/html_to_paginated_pdf.pdf' do
  @uri = params[:uri]
  filename = "paginated_pdf-#{Time.now.to_i}.pdf"
  cmd = "wkpdf --source #{@uri} --output #{filename} --margin 1 --print-background no --paginate yes --hcenter"
  `#{cmd}`
  file = File.open(filename, "rb")
  contents = file.read
  File.delete(filename)
  file.close
  
  content_type 'application/pdf'
  contents
end
