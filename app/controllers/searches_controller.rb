class SearchesController < ApplicationController
    include HTTParty
    skip_before_filter :verify_authenticity_token
    
    def index

    end 

    def show

        @bill = Bill.find(params[:format]) 
        rescue ActiveRecord::RecordNotFound
        redirect_to searches_search_path, :flash => { :alert => "Record not found." }
        
    end 

    def search
        if !params['subject'].nil? 
            @response = HTTParty.get('https://api.propublica.org/congress/v1/bills/search.json?query='+params['subject'], headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})['results'].first['bills']
                
            if !@response.nil?
                
                clear_old_search
                
                @response.each do |bill|
                    @bill  = Bill.new(
                       bill_id: bill['bill_id'],
                       title: bill['title'],
                       summary: bill['summary'],
                       date: bill['introduced_date'],
                       sponsor: bill['sponsor_name'],
                       sponsor_state: bill['sponsor_state'],
                       sponsor_party: bill['sponsor_party'],
                    #   status: bill['active'],
                       link: bill['congressdotgov_url']
                    )
                    @bill.user = current_user
                    @bill.save
                end
            end
            redirect_to request.path
        end
    end 

private 

    def clear_old_search
        @user = User.find(current_user.id)
        @bills = @user.bills
        
        if !@bills[0].nil?
            @bills.each do |bill|
                bill.destroy
            end 
        end 
    end 

end
