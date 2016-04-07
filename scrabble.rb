require 'sinatra'
require_relative 'lib/scoring'


class ScrabbleSinatra < Sinatra::Base

get '/' do
  erb :index
end

get '/score' do
  erb :score
end

post '/score' do # this defines a route, any requests that come in that "post" this is the block of code that will happen
  # peep is the name of the key in the hash that is located in the my_first_form file
  @wordscore = Scrabble::Scoring.score(params["word"].upcase) # this instantiates a new form
  @word = params["word"]
  erb :score
end

  run!
end
