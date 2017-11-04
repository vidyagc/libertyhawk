class FooController < ApplicationController
    skip_before_action :verify_authenticity_token
    def new
    end
    
    def search
        raise params.inspect
    end
end