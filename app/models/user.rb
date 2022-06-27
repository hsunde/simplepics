class User
	attr_reader :username
	
	def initialize(params)
		@username = params[:username]
		@email = params[:email]
		@password = params[:password]
	end

	def username_exists?
		unless DB.from(:user).where(username: @username).empty?
			return true
		end
	end

	def email_exists? 
		unless DB.from(:user).where(email: @email).empty?
			return true
		end
	end

	def is_admin?
		user_id = DB[:user].where(username: @username).first[:id]
		unless DB[:admin].where(user: user_id).empty?
			return true
		end
	end
end

class Login < User
	def authenticate
		password = DB.from(:user).where(username: @username).first[:password]
		return BCrypt::Password.new(password) == @password
	end
end

class Signup < User
	def create
		password = BCrypt::Password.create(@password)
		DB.from(:user).insert(username: @username, email: @email, password: password)
	end
end