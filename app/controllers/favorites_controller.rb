class FavoritesController < ApplicationController
    skip_before_filter :verify_authenticity_token

    before_action :authenticate_user_fav, only: [:create, :destroy] 
    
    include HTTParty
    
    def show

        @favorite = Favorite.find(params[:format]) 
    
        bill_slug = @favorite.bill_id.split('-')[0]
        congress = @favorite.bill_id.split('-')[1]
        @response = HTTParty.get('https://api.propublica.org/congress/v1/'+congress+'/bills/'+bill_slug+'.json', headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})['results'][0]
        
        @favorite.status = @response['active']
        
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
        redirect_to users_show_path, :flash => { :alert => "Record not found." }
    end 
   
    def create

        @bill = Bill.find(params[:id])
                
        @favorite  = Favorite.new(
            bill_id: @bill.bill_id,
            title: @bill.title,
            summary: @bill.summary,
            date: @bill.date,
            sponsor: @bill.sponsor,
            sponsor_state: @bill.sponsor_state,
            sponsor_party: @bill.sponsor_party,
            status: @bill.status,
            link: @bill.link
        )
        @favorite.user = current_user
        
        if @favorite.save
            # flash[:notice] = "Bill saved successfully."
        else
            if @favorite.errors.messages.empty?
                flash[:alert] = "Bill could not be saved"
            else 
                flash[:alert] = @favorite.errors.messages.first[1][0]
            end 
        end

        redirect_to params[:rdpath]
   end 
    
    def destroy
        @user = User.find(current_user)
        @favorite = Favorite.find(params[:id])
        
        if @favorite.destroy
            # flash[:notice] = "Bill was deleted from your saved bills."
            redirect_to users_show_path
        else
            flash[:alert] = "Bill couldn't be deleted. Try again."
            redirect_to users_show_path
        end
    end
    
    def destroy_search_bill
        @bill = Bill.find(params[:format])
        @favorite = Favorite.where(bill_id: @bill.bill_id).first
        if @favorite.destroy
            # flash[:notice] = "Bill was deleted from your saved bills."
            redirect_to params[:rdpath]
        else
            flash[:alert] = "Bill couldn't be deleted. Try again."
            redirect_to params[:rdpath]
        end
    end 
    
    private 

    def authenticate_user_fav 
        if !current_user
            flash[:alert] = "You need to be logged in to save bills."
            redirect_to searches_search_path
        end 
    end
    
end
