class RestaurantsController < ApplicationController

  def new
    @restaurant = Restaurant.new
  end

  def create

    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      respond_to do |format|
        format.html {render :show}
        format.json { render @restaurant}
      end
    else
      render 'new'
    end
  end

  def index
    @restaurants = Restaurant.all

    respond_to do |format|
      format.html # show.html.erb
      format.json
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comments = @restaurant.comments
    respond_to do |format|
      format.html # show.html.erb
      format.json { render @restaurant}
    end
  end


  def restaurant_params
    params.required(:restaurant).permit(:name, :address, :description)
  end
end
