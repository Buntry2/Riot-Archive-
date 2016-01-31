class CreateDays < ActiveRecord::Migration
  def self.up
    create_table :days do |t|
      t.string :date
      t.string :division
      t.integer :lp
      t.integer :score
    end
  end
  
  def self.down
    drop_table :days
  end
end
