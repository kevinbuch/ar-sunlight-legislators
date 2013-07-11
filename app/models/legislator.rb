require_relative '../../db/config'
require_relative 'tweet.rb'

class Legislator < ActiveRecord::Base
  has_many :tweets
  validates :phone, format: { with: //, message: 'must be a 10 digit phone number with no separators'}
  validates :state, format: { with: /\w\w/, message: 'must be a two letter state abbreviation' }

  def name_with_party
    "#{self.firstname} #{self.lastname} (#{self.party})"
  end

  def save_twitter_feed
    timeline = Twitter.user_timeline(self.twitter_id)
    timeline.each do |tweet|
      Tweet.create(text: tweet[:text], twitter_id: tweet[:id], legislators_id: self.id)
    end
  end

  def tweets
    Tweet.where("legislators_id = ?", self.id).map(&:text)
  end
end
