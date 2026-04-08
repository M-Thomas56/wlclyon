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

  def index_user
    @places = current_user.places
  end

  def new
    @place = Place.new
    @categories = Category.all
  end

  def create
    @place = PLace.find(params[:id])
    @place.user = current.user
    if @place.save
      redirect_to user_places_path, notice: "Lieu ajouté avec succès."
    else
      render json: { errors: @place.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to user_places_path, notice: "Lieu supprimé."
  end

  private

  def place_params
    params.require(:place).permit(:title, :content, :latitude, :longitude, :category_id)
  end
end
