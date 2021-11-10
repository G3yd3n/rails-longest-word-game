require 'json'
require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
    @t1 = Time.now
  end

  def score
    @point = 0
    t2 = Time.now
    @delta = t2 - params[:time_now].to_time
    @point += @delta.round/10
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    # binding.pry

    word_array = params[:word].downcase.split("")
    random_letters_no_space = params[:tags_list].gsub!(/\s+/,'')
    random_letters = random_letters_no_space.split("")
      # binding.pry

    if user["found"] && word_array.all? { |char| random_letters.include?(char)}
      @output_message = "Congratulations! #{params[:word].upcase} is a valid English word!"
      @point += 1
    elsif user["found"] && word_array.all? { |char| random_letters.include?(char)} == false
      # binding.pry
      @output_message = "Sorry but #{params[:word].upcase} can't be built out of #{params[:tags_list].upcase.split("").join(", ")}"
      @point = 0
    else
      @output_message = "Sorry but #{params[:word].upcase} does not seem to be a valid English word"
      @point = 0
    end

  end
end
