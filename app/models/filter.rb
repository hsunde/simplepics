module Filter
	class Active
		attr_accessor :active, :filtered_photos, :order_by, :group_by

		def initialize()
			@filtered_photos = []
		end

		def get()
			sql_base = DB[:tags].distinct.select(:file).join(:tag, id: :tag)

			sql = sql_base
			unless @active[:or].empty?
				sql = sql.where(name: @active[:or])
			end

			unless @active[:and].empty?
				sql_and = sql_base
				@active[:and].each do |tag|
					sql_and = sql_and.where(name: tag)
				end

				sql = sql.intersect(sql_and)
			end

			unless @active[:not].empty?
				sql_not = sql_base.where(name: @active[:not])
				sql = sql.except(sql_not)
			end

			type_sql = DB[:tags].join(:tag, id: :tag).join(:tag_category, id: :category).where(Sequel[:tag_category][:name] => "mediatype").select(Sequel[:tags][:file], Sequel[:tag][:name].as(:type))
			@filtered_photos = DB[:file].join(type_sql, file: :id).where(id: sql).order(Sequel.desc(:id)).all

			# p @filtered_photos
		end
	end
end