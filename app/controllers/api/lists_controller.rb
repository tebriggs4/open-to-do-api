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
    
    def destroy
        begin
            user = User.find(params[:user_id])
            list = user.lists.find(params[:id])
            list.destroy
            #  Return HTTP 204 No Content to indicate the server successfully processed
            # the request but is not returning any content.
            render json: {}, status: :no_content
        rescue ActiveRecord::RecordNotFound
            render :json => {}, :status => :not_found
        end
    end
    
    def update
        user = User.find(params[:user_id])
        list = user.lists.find(params[:id])
        if (current_user == list.user) && list.update(list_params)
            render json: list
        else
            render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private
    def list_params
        params.require(:list).permit(:title, :private)
    end
 
end