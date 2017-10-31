class ListsController < ApplicationController
   
   def new_form
   end
   
   def create_row
      @list = List.new
   
      @list.title = params[:title]
      @list.description = params[:description]
   
      @list.save
      
      redirect_to("/lists")
   end

   def index
      @lists = List.all
   end
   
   def show
      @list = List.find(params[:id])   
   end
   
   def edit_form
      @list = List.find(params[:id])
   end
   
   def update_row
      @list = List.find(params[:id])
      
      @list.title = params[:title]
      @list.description = params[:description]
      
      @list.save
      
      redirect_to("/lists/#{@list.id}")
      
   end
   
   def destroy_row
      @list = List.find(params[:id])
      @list.destroy
      
      redirect_to("/lists")
   end
    
end