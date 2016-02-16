class Admin::VenuesController < ApplicationController

  def index
    @venues = Venue.all
  end

  def new
  end

  def show
    @venue = Venue.find_by(id: params[:id])
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