class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.string  :date
      t.integer :mode #0 for ranked #1 for normal #2 for ranked team #-1 for everything else
      t.boolean :outcome
      
      t.integer :game_id
      t.integer :team_id #1 for blue, #2 for red
      
      t.string  :champion
      t.integer :kills
      t.integer :deaths
      t.integer :assists
      t.integer :cs
      
      t.float :kda
      t.float :kill_participation
      
      t.float :ge   #Gold Earned
      t.float :dg   #Damage Given
      t.float :dpg  #Damage per Gold
      t.float :dpot #Damage Percent of Team
      t.float :gpot #Gold Percent of Team
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :matches
  end
end
