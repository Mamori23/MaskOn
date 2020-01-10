require './server'
run Sinatra::Application

configure :production do 
    set :database{url: ENV['DATABASE_URL']}
  end