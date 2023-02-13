class WinesController < ApplicationController
  def index
    @wines = Wine.order(rating: :desc)
  end

  def show
  end
end
