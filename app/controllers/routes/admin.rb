class Simplepics < Sinatra::Base
	before "/admin/*" do
		unless user_admin?
			halt 403
		end
	end

	get "/admin/tag" do
		@tags = get_categories()
		erb :"admin/tag"
	end

	# post "/admin/tag/change_category" do
	# 	tag = params[:tag]
	# 	category = params[:category]

	# 	Admin::Tags::update_category(params[:tag], params[:category])
	# 	redirect "/admin/tags"
	# end
end