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
    @wordscore = Scrabble::Scoring.score(params["word"]) # this instantiates a new form
    @word = params["word"]
    erb :score
  end

  get '/score_many' do
    erb :score_many
  end

  post '/score_many' do
    @collection_of_words = Scrabble::Scoring.many_words(params["words"])
    @words = params["words"]
  erb :score_many
  end

  run!
end
