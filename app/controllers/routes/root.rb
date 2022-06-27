class Simplepics < Sinatra::Base
	not_found do
		return 404
	end

	get "/" do
		@categories = get_categories()
		session[:filter] = Filter::Active.new()

		erb :index
	end
end