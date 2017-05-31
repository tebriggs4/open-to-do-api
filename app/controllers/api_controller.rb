class ApiController < ApplicationController

    skip_before_action :verify_authenticity_token
    
    private
    
    def authenticated?
        
        # implements basic HTTP authentication, which ensures HTTP requests are accompanied by a valid username and password.
        
        authenticate_or_request_with_http_basic {|name, password| User.where( name: name, password: password ).present? }
    end
 
end