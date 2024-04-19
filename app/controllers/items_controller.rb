class ItemsController < ApplicationController
  before_action :initializeItems, only: %i[index show edit new]
  before_action :set_storage
  before_action :init_hash_id
  before_action :set_item, only: %i[ show edit update destroy ]

  def index
    @items = @curr_storage.items
  end

  def show
        
  end
  
  def new   
    @item = Item.new 
    @unit = Units::UNITS
  end
  
  def create
    @item = @curr_storage.items.new(item_params)
    @item.save
  end
  
  def edit
  end

  def update
    @item.update(item_params)
  end

  def destroy
    @item.destroy!
    respond_to do |format|
      format.html { redirect_to "/#{@curr_storage.name}/items", notice: "Item was successfully destroyed."}
    end
  end

  private
    def initializeItems
        @selected_side_menu = SideMenu::ITEMS 
    end

    def init_hash_id
      @hashids = Hashids.new(ENV["ITEM_SALT_VALUE"], 16)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      decoded_id = @hashids.decode(params[:id])[0]
      @item = @curr_storage.items.find(decoded_id)
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.permit(:name, :quantity, :unit, :description, :cost_price, :sell_price)
    end
    
end
