class SubjectSearchesController < ApplicationController
    include HTTParty
    
    def index
        @subjectsearch = SubjectSearch.all
    end 

    def search
        if !params['subject'].nil? 
            @response = HTTParty.get('https://api.propublica.org/congress/v1/bills/subjects/'+params['subject']+'.json', headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})['results']
            @results = @response[0] unless @response.nil? 
        end 
    end

# put results into SubjectSearch models 

    def new
        @subjectsearch = SubjectSearch.new
    end 
    
    def create
        @subjectsearch = SubjectSearch.new
        @subjectsearch.metadata = params[:subjectsearch][:metadata]
        #@wiki.user = current_user
    
        # if @wiki.save
        #     flash[:notice] = "Wiki was saved."
        #     redirect_to @wiki
        #     #redirect_to [@topic, @post]
        # else
        #     flash.now[:alert] = "There was an error saving the wiki. Please try again."
        #     render :new
        # end
    end

end
