# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

include HTTParty

response = HTTParty.get('https://api.propublica.org/congress/v1/bills/subjects/{subject}.json', headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})
parsed = JSON.parse(response)

# (102..115).to_a.each do |cs_number|
#     response = HTTParty.get("https://api.propublica.org/congress/v1/#{cs_number}/house/members.json", headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})
#     parsed = JSON.parse(response)
# end

# (80..115).to_a.each do |cs_number|
#     response = HTTParty.get("https://api.propublica.org/congress/v1/#{cs_number}/senate/members.json", headers: {'X-API-Key' => 'kPp4zjf2X6vnYw81m5WND22ZcsLJAKYKmQsleEiR'})
#     parsed = JSON.parse(response)
# end