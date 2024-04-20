class SalesController < ApplicationController
    before_action :initializeSales, only: %i[index show edit new]
    before_action :set_storage
    before_action :init_hash_id
    before_action :set_sales, only: %i[ show edit update destroy ]
    def index
        @sales = @curr_storage.sales      
    end

    def show
        
    end

    def new
        @sales = Sale.new
    end

    def create
        sales_params
        @sale = @curr_storage.sales.new(transaction_date: params[:transaction_date], note: params[:note], shipping_charge: params[:shipping_charge], total_amount: params[:total_amount])
        items_data = JSON.parse(params[:items_data])
    
        if @sale.save
            items_data.each do |data|
                item = @curr_storage.items.find(data["item_id"])
                link_item_sale(@sale, item, data["quantity"], data["discount_val"], data["discount_unit"], data["amount"])                  
            end
        end            
    end

    def search_item
        # Perform the search based on the input received
        @search_results = @curr_storage.items.where("name LIKE ?", "%#{params[:query]}%")
        # Respond with JSON containing the search results
        render json: @search_results
    end

    def create_sale
        # Parse the JSON data sent from the client
        rows_data = JSON.parse(params[:items_data])
    
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

    def init_hash_id
        @hashids = Hashids.new(ENV["ITEM_SALT_VALUE"], 16)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_sales
        decoded_id = @hashids.decode(params[:id])[0]
        @sale = @curr_storage.sales.find(decoded_id)
    end

    # Only allow a list of trusted parameters through.
    def sales_params
        params.permit(:transaction_date, :note, :shipping_charge, :total_amount, :authenticity_token, :search_item, :quantity, :discount_value, :discount_unit, :items_data, :storage)
    end

    def link_item_sale(sale, item, quantity, discount_val, discount_unit, amount)
        item_sale = ItemSale.new(sale: sale, item: item, quantity: quantity, discount_val: discount_val, discount_unit: discount_unit, amount: amount)
        item_sale.save
    end

end
