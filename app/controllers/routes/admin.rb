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

	post "/admin/tag/change_category" do
		tag = params[:tag]
		category = params[:category]

		tag_record = Tag[name: tag]
		category_record = TagCategory.find_or_create(name: category)

		category_record.add_tag(tag_record)
		redirect "/admin/tags"
	end
end