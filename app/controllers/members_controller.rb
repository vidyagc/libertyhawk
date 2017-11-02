class MembersController < ApplicationController
    include HTTParty
    
    def index
        @members = HTTParty.get('https://api.propublica.org/congress/v1/102/house/members.json', headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})
    end
end