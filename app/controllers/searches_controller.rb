class SearchesController < ApplicationController
    include HTTParty
    skip_before_filter :verify_authenticity_token
    
    def index
    end 

    def sort
        current_user.update(:sort => params[:sort_type])
        redirect_to searches_search_path
    end 

    def show
        if user_signed_in?
            @bill = Bill.find(params[:format]) 

            bill_slug = @bill.bill_id.split('-')[0]
            congress = @bill.bill_id.split('-')[1]
        
        else
            bill_slug = params[:bill_id].split('-')[0]
            congress = params[:bill_id].split('-')[1]
        end 
        
        @response = HTTParty.get('https://api.propublica.org/congress/v1/'+congress+'/bills/'+bill_slug+'.json', headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})['results'][0]
        
        @status = @response['active']
        
        if !user_signed_in?
            @bill  = Bill.new(
               bill_id: @response['bill_id'],
               title: @response['short_title'],
               summary: @response['summary'],
               date: @response['introduced_date'],
               sponsor: @response['sponsor_name'],
               sponsor_state: @response['sponsor_state'],
               sponsor_party: @response['sponsor_party'],
               status: @response['active'],
               link: '<script id="govtrack:widget:bill:'+congress+':'+bill_slug+':script" src="https://www.govtrack.us/congress/bills/'+congress+'/'+bill_slug+'/widget.js" type="text/javascript"></script>'
            )
        end 
        
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
            @description = HTTParty.get(vote['api_url'], headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})['results']['votes']['vote']['description']
            @vote  = Vote.new(
                chamber: vote['chamber'],
                date: vote['date'],
                time: vote['time'],
                roll_call: vote['roll_call'],
                question: vote['question']+"<br><u>Description</u><br>"+@description,
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
        redirect_to searches_search_path, :flash => { :alert2 => "Record not found." }
    end 

    def search
        if params['subject'].present? 
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
                if current_user && current_user.searches.count > 10 
                    @lastSearch = current_user.searches.first
                    @lastSearch.destroy 
                end 
                
                @response.each do |bill|
                    bill_slug = bill['bill_id'].split('-')[0]
                    congress = bill['bill_id'].split('-')[1]
                    
                    # not all bills have a short_title, so this conditional ensure the title isn't nil
                    if !bill['short_title'].nil?
                        btitle=bill['short_title']
                    else 
                        btitle=bill['title']
                    end 
                    
                    # raise bill['short_title'].to_s.length
                    @bill  = Bill.new(
                       bill_id: bill['bill_id'],
                       title: btitle,
                       summary: bill['summary'],
                       date: bill['introduced_date'],
                       sponsor: bill['sponsor_name'],
                       sponsor_state: bill['sponsor_state'],
                       sponsor_party: bill['sponsor_party'],
                       status: bill['active'],
                       link: '<script id="govtrack:widget:bill:'+congress+':'+bill_slug+':script" src="https://www.govtrack.us/congress/bills/'+congress+'/'+bill_slug+'/widget.js" type="text/javascript"></script>'
                    )
                    if user_signed_in? 
                        @bill.user = current_user
                        @bill.save
                    else
                        @tempBills << @bill
                    end 
                end
            else 
                if !user_signed_in?
                    redirect_to root_path, :flash => { :alert2 => "Your search yielded no results." }
                else 
                    redirect_to request.path, :flash => { :alert2 => "Your search yielded no results." }
                    clear_old_search
                    return 
                end 
            end
            if user_signed_in?
                redirect_to searches_search_path
            end 
        end
    end 

private 

    def clear_old_search
        @user = User.find(current_user.id)
        @bills = @user.bills
        current_user.sort=nil
        
        if !@bills[0].nil?
            @bills.each do |bill|
                bill.destroy
            end 
        end 
    end 

end
