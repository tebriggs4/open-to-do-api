class ApiController < ApplicationController

    skip_before_action :verify_authenticity_token
    
    attr_reader :current_user
    
    private
    
    def authenticated?
        
        # implements basic HTTP authentication, which ensures HTTP requests are accompanied by a valid username and password.
        
        authenticate_or_request_with_http_basic do |name, password|
            @current_user = User.where(name: name, password: password).first
            @current_user.present?
        end
    end
 
end