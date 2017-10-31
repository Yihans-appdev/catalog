require 'open-uri'

class FoodsController < ApplicationController

  def index
    @foods = Food.all

    render("foods_templates/index.html.erb")
  end

  def show
    @food = Food.find(params[:id])

    #add street address to URL head
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @food.store_address
    url = url.gsub(" ","+")
    
    #get json
    parsed_data = JSON.parse(open(url).read)
    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    render("foods_templates/show.html.erb")
  end

  def new_form
    render("foods_templates/new_form.html.erb")
  end

  def create_row
    @food = Food.new

    @food.ingredient = params[:ingredient]
    @food.spice = params[:spice]
    @food.measurement = params[:measurement]
    @food.store_address = params[:store_address]
    @food.save

    redirect_to("/foods")
  end

  def edit_form
    @food = Food.find(params[:id])

    render("foods_templates/edit_form.html.erb")
  end

  def update_row
    @food = Food.find(params[:id])

    @food.ingredient = params[:ingredient]
    @food.spice = params[:spice]
    @food.measurement = params[:measurement]
    @food.store_address = params[:store_address]

    @food.save

    redirect_to("/foods/#{@food.id}")
  end

  def destroy_row
    @food = Food.find(params[:id])
    @food.destroy

    redirect_to("/foods")
  end
end
