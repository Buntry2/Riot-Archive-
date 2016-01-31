class CreateUserMatches < ActiveRecord::Migration
  def self.up
    create_table :user_matches do |t|
      t.integer :user_id
      t.integer :match_id
    end
  end
  
  def self.down
    drop_table :user_matches
  end
end
