class Api::ItemsController < ApiController

    before_action :authenticated?
 
    def create
        list = List.find(params[:list_id])
        item = list.items.build(item_params)
        if item.save
            # Rails searches for a serializer for the object and use it if it is available. 
            # Rails will look for a serializer named ItemSerializer and use it to serialize item.
            render json: item
        else
            # return the error messages and a 422 status code indicating that the data sent was un-processable
            render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def update
        list = List.find(params[:list_id])
        item = list.items.find(params[:id])
        if (current_user == item.list.user) && item.update(item_params)
            render json: item
        else
            render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private
    def item_params
        params.require(:item).permit(:name, :completed)
    end

end