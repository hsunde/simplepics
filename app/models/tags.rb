def get_categories()
	categories_with_tags = {}
	categories = DB[:tag_category].order(:name).all

	categories.each do |category|
		id = category[:id]
		category = category[:name]

		tags = DB.from(:tag).where(category: id).select(:name).order(:name).all

		categories_with_tags[category] = tags
	end

	return categories_with_tags
end