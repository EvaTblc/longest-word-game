require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Range.new('A', 'Z').to_a.sample(10)
  end

  def score
    @word = params[:letters].split(//)
    @word.delete(' ')
    @result = params[:result].upcase.split(//)

    url = "https://wagon-dictionary.herokuapp.com/#{params[:result]}"
    dictionnary_serialized = URI.open(url).read
    dictionnary = JSON.parse(dictionnary_serialized)

    case @result.all? { |letter| @result.count(letter) == @word.count(letter) }
    when dictionnary['found'] == true
      @answer = "Congratulations ! #{params[:result]} is a valid english word"
    when dictionnary['found'] == false
      @answer = "Sorry but #{params[:result]} does not seem to be an english word"
    else
      @answer = "Sorry but #{params[:result]} can't be built out of #{params[:letters]}"
    end
  end
end
