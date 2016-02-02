require 'bundler'
Bundler.require

configure :development do
  set :database, "sqlite3:db/database.db"
end

configure :production do
    set :database, "postgresql:db/database.db"
end