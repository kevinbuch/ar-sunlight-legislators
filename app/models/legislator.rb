require_relative '../../db/config'

class Legislator < ActiveRecord::Base
  validates :phone, format: { with: //, message: 'must be a 10 digit phone number with no separators'}
  validates :state, format: { with: /\w\w/, message: 'must be a two letter state abbreviation' }

  def name_with_party
    "#{self.firstname} #{self.lastname} (#{self.party})"
  end
end
