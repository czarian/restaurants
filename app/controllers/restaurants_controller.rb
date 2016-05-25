class RestaurantsController < ApplicationController

  def new
    @restaurant = Restaurant.new
  end

  def create

    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to @restaurant
    else
      render 'new'
    end
  end

  def index
    @restaurants = Restaurant.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @restaurants }
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comments = @restaurant.comments
  end


  def restaurant_params
    params.required(:restaurant).permit(:name, :address, :description)
  end
end
