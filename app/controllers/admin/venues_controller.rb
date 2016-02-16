class Admin::VenuesController < ApplicationController

  # CRUD
  # CREATE 
  # READ (get)
  # UPDATE 
  # DESTROY

  def index
    @venues = Venue.all
  end

  def new
  end

  def show
    @venue = Venue.find_by(id: params[:id])
    @array = ['what', 'hi', 'there']
    @new_var = @venue.name_and_description
  end

  def edit
  end

  def update

  end

  private

  def venue_params
    params.require(:venue).permit(:name, :address_id, :venue_type)
  end

end