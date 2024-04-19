class SalesController < ApplicationController
    before_action :initializeSales, only: %i[index show edit new]
    before_action :set_storage
    before_action :set_sales, only: %i[ show edit update destroy ]
    def index
        @curr_storage.sales      
    end

    def show
        
    end

    def new
        @sales = Sale.new
        @items = @curr_storage.items
    end

    def create
        @sales = Sale.new(sales_params)
    end

    def create_sale
        # Parse the JSON data sent from the client
        rows_data = JSON.parse(params[:rows_data])
    
        # Print the received data to the console
        puts "Received data:"
        puts rows_data
    
        # Respond with a success message
        redirect_to root_path, notice: 'Sales created successfully'
      rescue JSON::ParserError => e
        # Handle JSON parsing errors
        redirect_to root_path, alert: 'Invalid JSON format'
      rescue StandardError => e
        # Handle other errors
        redirect_to root_path, alert: e.message
      end
      
    def edit

    end

    def update

    end

    def destroy

    end

    private

    def initializeSales
        @selected_side_menu = SideMenu::SALES    
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_sales
        @item = @curr_storage.sales.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sales_params
        params.require(:sale).permit(:transaction_date)
    end

end
