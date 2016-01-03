require 'bcrypt'

class User < ActiveRecord::Base
    has_many :reviews
    has_many :votes
    
    include BCrypt

	def password
		@password ||= Password.new(password_hash)
	end

	def password=(new_password)
		@password = Password.create(new_password)
		self.password_hash = @password
	end
    
    def authenticate(attempted_password)
        return self.password == attempted_password
    end

end

if User.count == 0
    user = User.new(username: "admin")
    user.password = "admin"
    user.save
end