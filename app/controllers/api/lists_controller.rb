class Api::ListsController < ApiController
    
    before_action :authenticated?
 
    def create
        user = User.find(params[:user_id])
        list = user.lists.build(list_params)
        if list.save
            # Rails searches for a serializer for the object and use it if it is available. 
            # Rails will look for a serializer named ListSerializer and use it to serialize list.
            render json: list
        else
            # return the error messages and a 422 status code indicating that the data sent was un-processable
            render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private
    def list_params
        params.require(:list).permit(:title, :private)
    end
 
end