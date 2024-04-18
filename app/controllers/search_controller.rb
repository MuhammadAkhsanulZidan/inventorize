class SearchController < ApplicationController
    before_action :set_storage 
    def search_item
        # Perform the search based on the input received
        @search_results = @curr_storage.items.where("name LIKE ?", "%#{params[:query]}%")
        # Respond with JSON containing the search results
        render json: @search_results
    end
end