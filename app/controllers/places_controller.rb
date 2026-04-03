class PlacesController < ApplicationController
  def index
    @places = Place.all
    render json: @places
  end

  def create
    @place = Place.new(place_params)
    @place.user = current_user
    if @place.save
      render json: @place, status: :created
    else
      render json: { errors: @place.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def place_params
    params.require(:place).permit(:title, :content, :latitude, :longitude, :category_id)
  end
end
