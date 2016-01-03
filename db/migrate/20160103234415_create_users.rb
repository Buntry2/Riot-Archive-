class CreateUsers < ActiveRecord::Migration
    
    # Whenever we create a table called users this method will be called. It creates a table in the
    #   sqlite3 database called users. Users have 4 qualities defined here: their username (strings)
    #   their password_hashs (BCrypt gibberish that encrypts passwords, Look at models/User) and two
    #   ruby time classes that define when the User was created and when the User was last updated
    def self.up
        create_table :users do |t|
            t.string :username
            t.string :password_hash
            
            t.timestamps
        end
    end
    
    # When we want to rollback the database, we use this method. It just deletes the table.
    def self.down
        drop_table :users
    end
end
