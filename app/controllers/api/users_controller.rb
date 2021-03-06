class Api::UsersController < ApiController
    
    before_action :authenticated?
    
    def index
        
        users = User.all

        render json: users, each_serializer: UserSerializer
    end
    
    def create
        user = User.new(user_params)
        if user.save
            # Rails searches for a serializer for the object and use it if it is available. 
            # Rails will look for a serializer named UserSerializer and use it to serialize user.
            render json: user
        else
            # return the error messages and a 422 status code indicating that the data sent was un-processable
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        begin
            user = User.find(params[:id])
            user.destroy
            #  Return HTTP 204 No Content to indicate the server successfully processed
            # the request but is not returning any content.
            render json: {}, status: :no_content
        rescue ActiveRecord::RecordNotFound
            render :json => {}, :status => :not_found
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :password)
    end

end