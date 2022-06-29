class Simplepics < Sinatra::Base
	VIEW_LIMIT = 100

	configure do
		register Sinatra::Reloader
		helpers Sinatra::ContentFor

		enable :sessions
		# set :session_secret, SecureRandom.hex(64)
		set :session_secret, "lol"

		set :views, 'app/views'
		set :public_folder, 'public'
	end

	helpers do
		def login_user(username)
			session[:user] = username
			session[:login_failed] = false
			redirect "/"
		end

		def user_loggedin?()
			if session[:user]
				return true
			end
		end

		def user_admin?
			user = User[username: session[:user]]

			if user && Admin[user: user[:id]]
				return true
			end
		end	
	end	
end