require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(15) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split(' ')
    @word = params[:word].upcase

    @included = @word.chars.all? do |letter|
      @word.count(letter) <= @letters.count(letter)
    end

    @english_word = english_word?(@word)
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
