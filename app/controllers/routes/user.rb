class Simplepics < Sinatra::Base
	get "/signup" do
		erb :signup
	end

	post "/signup" do
		username = params[:username]
		email = params[:email]
		password = params[:password]

		if User[username: username] || User[email: email]
			redirect "/signup"
		else
			User.create(username: username, email: email, password: BCrypt::Password.create(password))
			login_user(username)
		end
	end	

	get "/login" do
		erb :login
	end

	post "/login" do
		user = User[username: params[:username]]
		if user && BCrypt::Password.new(user[:password]) == params[:password]
			login_user(user[:username])
		end
	end	

	get "/logout" do
		session.clear
		redirect "/"
	end	

    get "/username" do
        if user_loggedin?
            return session[:user]
        end
    end	
end