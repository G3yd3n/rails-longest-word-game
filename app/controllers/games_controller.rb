class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
    puts "*" *20
    p @letters
  end

  def score
  end
end
