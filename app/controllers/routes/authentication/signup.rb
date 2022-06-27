class Simplepics < Sinatra::Base
	get "/signup" do
		erb :signup
	end

	post "/signup" do
		user = Signup.new(params)

		if user.username_exists? || user.email_exists?
			redirect "/signup"
		else
			user.create
			login_user(user)
		end
	end
end