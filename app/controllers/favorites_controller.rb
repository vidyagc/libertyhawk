class FavoritesController < ApplicationController
    skip_before_filter :verify_authenticity_token
    include HTTParty
    
    def show
        # @response = HTTParty.get('https://api.propublica.org/congress/v1/{congress}/bills/'+params['favorite-id']+'.json', headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})['results'].first['bills']
        # get actions and votes 
        
        
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
            # status: @bill.status,
            link: @bill.link
        )
        @favorite.user = current_user
        
        if @favorite.save
            flash[:notice] = "Bill saved successfully."
        else
            if @favorite.errors.messages.empty?
                flash[:alert] = "Bill could not be saved"
            else 
                flash[:alert] = @favorite.errors.messages.first[1][0]
            end 
        end
        redirect_to searches_search_path
   end 
    
    def destroy
        @user = User.find(current_user)
        @favorite = Favorite.find(params[:id])
        
        if @favorite.destroy
            flash[:notice] = "Bill was deleted."
            redirect_to users_show_path(@user)
        else
            flash[:alert] = "Bill couldn't be deleted. Try again."
            redirect_to users_show_path(@user)
        end
    end
    
    def destroy_search_bill
        @bill = Bill.find(params[:format])
        @favorite = Favorite.where(bill_id: @bill.bill_id).first
        
        if @favorite.destroy
            flash[:notice] = "Bill was deleted from your saved bills."
            redirect_to searches_search_path
        else
            flash[:alert] = "Bill couldn't be deleted. Try again."
            redirect_to searches_search_path
        end
    end 
    
end
