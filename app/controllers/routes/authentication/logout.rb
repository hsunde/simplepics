class Simplepics < Sinatra::Base
	get "/logout" do
		session.clear
		redirect "/"
	end	
end