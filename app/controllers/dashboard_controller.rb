class DashboardController < ApplicationController
    before_action :initializeDashboard
    before_action :set_storage

    def index

    end

    private
        def initializeDashboard
            @selected_side_menu = SideMenu::DASHBOARD        
            # @user = current_user
        end
    
end
