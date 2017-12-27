class SearchesController < ApplicationController
    include HTTParty
    skip_before_filter :verify_authenticity_token
    
    def index

    end 

    def show

        @bill = Bill.find(params[:format]) 
        
        bill_slug = @bill.bill_id.split('-')[0]
        congress = @bill.bill_id.split('-')[1]
        @response = HTTParty.get('https://api.propublica.org/congress/v1/'+congress+'/bills/'+bill_slug+'.json', headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})['results'][0]
        
        @status = @response['active']
        
        @bill.status = @status
        
        @actions = []
        @response['actions'].each do |action|
            @action  = Action.new(
                action_id: action['id'],
                chamber: action['chamber'],
                action_type: action['action_type'],
                date: action['datetime'],
                description: action['description']
            )
            @actions << @action
        end 
        
        @votes = []
        @response['votes'].each do |vote|
            @latest_action = HTTParty.get(vote['api_url'], headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})['results']['votes']['vote']['bill']['latest_action']
            @vote  = Vote.new(
                chamber: vote['chamber'],
                date: vote['date'],
                time: vote['time'],
                roll_call: vote['roll_call'],
                question: vote['question']+"\n"+"LATEST ACTION:"+"\n"+@latest_action,
                # vote['question'],
                result: vote['result'],
                yea: vote['total_yes'],
                nay: vote['total_no'],
                not_voting: vote['total_not_voting'],
                api_url: vote['api_url']        
            )
            @votes << @vote
        end 
        
        rescue ActiveRecord::RecordNotFound
        redirect_to searches_search_path, :flash => { :alert => "Record not found." }
    end 

    def search
        if !params['subject'].nil? 
            @response = HTTParty.get('https://api.propublica.org/congress/v1/bills/search.json?query='+params['subject'], headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})['results'].first['bills']
                # raise @response.inspect
            if @response.any?
                if user_signed_in?
                    clear_old_search
                else 
                    @tempBills = []
                end 
                
                @search = Search.new(
                    metadata: params['subject']
                )
                @search.user = current_user
                @search.save
                if current_user.searches.count > 10 
                    @lastSearch = current_user.searches.first
                    @lastSearch.destroy 
                end 
                
                @response.each do |bill|
                    @bill  = Bill.new(
                       bill_id: bill['bill_id'],
                       title: bill['short_title'],
                       summary: bill['summary'],
                       date: bill['introduced_date'],
                       sponsor: bill['sponsor_name'],
                       sponsor_state: bill['sponsor_state'],
                       sponsor_party: bill['sponsor_party'],
                       status: bill['active'],
                       link: bill['congressdotgov_url']
                    )
                    if user_signed_in? 
                        @bill.user = current_user
                        @bill.save
                    else 
                        @tempBills << @bill
                    end 
                end
            else 
                # error message for no result search - add to bills error array and put in header, like in Wikit
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
