module Refinery
  module Breads
    module Admin
      class BreadsController < ::Refinery::AdminController

        crudify :'refinery/breads/bread',
                :title_attribute => 'name'

        private

        # Only allow a trusted parameter "white list" through.
        def bread_params
          params.require(:bread).permit(:name, :description, :photo_id)
        end
      end
    end
  end
end
