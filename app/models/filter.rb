class Filter
	def self.apply(tags)
		sql_base = DB[:tags].distinct.select(:file).join(:tag, id: :tag)

		sql = sql_base
		unless tags[:or].empty?
			sql = sql.where(name: tags[:or])
		end

		unless tags[:and].empty?
			sql_and = sql_base
			tags[:and].each do |tag|
				sql_and = sql_and.where(name: tag)
			end

			sql = sql.intersect(sql_and)
		end

		unless tags[:not].empty?
			sql_not = sql_base.where(name: tags[:not])
			sql = sql.except(sql_not)
		end

		type_sql = DB[:tags].join(:tag, id: :tag).join(:tag_category, id: :category).where(Sequel[:tag_category][:name] => "mediatype").select(Sequel[:tags][:file], Sequel[:tag][:name].as(:type))
		return DB[:file].join(type_sql, file: :id).where(id: sql).order(Sequel.desc(:id)).all
	end
end