class SubjectSearchesController < ApplicationController
    include HTTParty
    skip_before_filter :verify_authenticity_token
    
    def index
        @subjectsearch = SubjectSearch.all
    end 

    def search
        if !params['subject'].nil? 
            @response = HTTParty.get('https://api.propublica.org/congress/v1/bills/subjects/'+params['subject']+'.json', headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})['results']
            if !@response.nil? 
                @results = @response[0]
            end 
        end 
    end 

# put results into SubjectSearch models 

    def new
        @subjectsearch = SubjectSearch.new
    end 
    
    def create
        @subjectsearch = SubjectSearch.new(:metadata =>params[:metadata])
        @subjectsearch.user = current_user
        @subjectsearch.save
        redirect_to subject_searches_search_path
    end

end
