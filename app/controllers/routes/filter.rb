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

		session[:filter].active = active
		session[:filter].get()

		return session[:filter].filtered_photos.to_json
	end
end