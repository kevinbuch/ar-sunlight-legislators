require_relative '../db/config'
require_relative 'models/legislator'
require_relative 'models/senator'
require_relative 'models/representative'
require 'twitter'

def state_reps(state)
  puts 'Senators:'
  senators = Senator.where("state = ?", state)
  senators.each { |senator| puts '  ' + senator.name_with_party }
  puts 'Representatives:'
  reps = Representative.where("state = ?", state)
  reps.each { |rep| puts '  ' + rep.name_with_party }
end

state_reps('CA')

def gender_split(gender)
  all_senators = Senator.count
  senators_gender = Senator.where("gender = ?", gender).count
  all_reps = Representative.count
  reps_gender = Representative.where("gender = ?", gender).count
  puts "#{gender} Senators: #{senators_gender} #{(senators_gender.to_f/all_senators.to_f*100.0).floor}%"
  puts "#{gender} Representatives: #{reps_gender} #{(reps_gender.to_f/all_reps.to_f*100.0).floor}%"
end

gender_split('M')

senators = Legislator.group(:state).count(conditions: "type = 'Senator'")
representatives = Legislator.group(:state).count(conditions: "type = 'Representative'")
senators.each do |state, count|
  puts "#{state}: #{count} Senators, #{representatives[state]} Representatives"
end

puts "Senators: #{Senator.count}"
puts "Representatives: #{Representative.count}"

Legislator.delete_all("in_office = 0")

puts "Senators: #{Senator.count}"
puts "Representatives: #{Representative.count}"

# SELECT state, count(type = 'Senator'), count(type = 'Representative') FROM legislators GROUP BY state;

Twitter.configure do |config|
  config.consumer_key = 'Wo3Z7WTQaYZC7L9i2xZQ'
  config.consumer_secret = 'MU0Ih3q3h3XqT4nXt5qfcxNwZ85RXXHS0VDFwwmrQQ'
  config.oauth_token = '1374694152-iDocj1sHRa0WdptboQWG52WW8Yr7uoQhuARaQak'
  config.oauth_token_secret = 'ieWn99Z1oJ0cJLPLGl83o4IuhNdSLnI3q4Y8IEE'
end

tweeter = Legislator.find(2)
tweeter.save_twitter_feed
puts tweeter.tweets
