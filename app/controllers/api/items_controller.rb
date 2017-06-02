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

    private
    def item_params
        params.require(:item).permit(:name)
    end

end