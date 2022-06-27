class Simplepics < Sinatra::Base
	before "/admin/*" do
		unless user_admin?
			halt 403
		end
	end

	get "/admin/tags" do
		@tags = get_categories()
		erb :"admin/tags"
	end

	post "/admin/tags/change" do
		Admin::Tags::update_category(params[:tag], params[:category])
		redirect "/admin/tags"
	end
end