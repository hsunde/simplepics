class Simplepics < Sinatra::Base
	post "/filter" do
		a = JSON.parse(params[:active])

		active = {
			or: [],
			and: [],
			not: []
		}

		a.each do |tag, operator|
			active[operator.to_sym] << tag
		end

		@categories = get_categories()	

		session[:filter].active = active
		session[:filter].get()
		@count = session[:filter].filtered_photos.length
		@pages = (@count/VIEW_LIMIT.to_f).ceil

		return session[:filter].filtered_photos.to_json
	end
end