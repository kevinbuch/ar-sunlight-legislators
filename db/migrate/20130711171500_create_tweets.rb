require_relative '../config'

class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.references :legislators
      t.string :text
      t.integer :twitter_id
    end
  end
end
