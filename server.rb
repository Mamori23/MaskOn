require 'sinatra'
require 'sinatra/activerecord'
require "sinatra/activerecord/rake"
require_relative './server'

set :database, {adapter: 'sqlite3', database: 'maskon.sqlite3'}
enable :sessions

get '/' do
    erb :home
end
