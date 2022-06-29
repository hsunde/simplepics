class Simplepics < Sinatra::Base
	not_found do
		return 404
	end

	get "/" do
		erb :index
	end
end