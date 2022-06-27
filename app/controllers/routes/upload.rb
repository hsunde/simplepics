class Simplepics < Sinatra::Base
	get "/upload" do
		if user_loggedin?
			erb :upload
		else
			redirect "/login"
		end
	end

	post "/upload" do
		unless user_loggedin?
			return 403
		end

		if params[:sequence] == 'true'
			sequence = true
		else
			sequence = false
		end

		Upload::add(sequence, params[:tags], params[:files])

		return 200
	end
end