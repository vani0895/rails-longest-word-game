require "open-uri"

class GamesController < ApplicationController
  def new(size = 10)
    @chars = %w{A B C D E F G H I J K M N O P Q R S T U V W X Y Z}
    @letters = (0...size).map { @chars.to_a[rand(@chars.size)] }.join
  end
  def score
    @choice = params[:word].upcase
    @letters = params[:letters].upcase
    url = "https://dictionary.lewagon.com/#{@choice}"
    @word_serialized = URI.open(url).read
    @word = JSON.parse(@word_serialized)
    if @word["found"] == true && @choice.chars.any? { |letter| @choice.count(letter) >= @letters.count(letter) }
      @answer = "Great, #{@choice} is a good answer!"
    else
      @answer = 'Wrong answer'
    end
  end
end
