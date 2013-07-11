require_relative '../../db/config'

class Tweet < ActiveRecord::Base
  belongs_to :legislator
  validates :twitter_id, uniqueness: true

end
