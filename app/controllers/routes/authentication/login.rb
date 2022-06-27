class Simplepics < Sinatra::Base
	get "/login" do
		erb :login
	end

	post "/login" do
		user = Login.new(params)

		if user.username_exists? && user.authenticate
			login_user(user)
		else
			session[:login_failed] = true
			redirect "/login"
		end
	end
end