class Simplepics < Sinatra::Base
	post "/filter" do
		a = JSON.parse(params[:active])

		active_tags = {
			or: [],
			and: [],
			not: []
		}

		a.each do |tag, operator|
			active_tags[operator.to_sym] << tag
		end

		return Filter.apply(active_tags).to_json
	end
end