class Simplepics
	module ContentFile
		module Tags
			extend self
			
			def get(file_id)
				return DB.from(:tags).join(:tag, id: :tag).select(:name).where(file: file_id).all
			end

			def remove(file_id, tag)
				tag_id = DB.from(:tag).where(name: tag).first[:id]
				DB.from(:tags).where(file: file_id, tag: tag_id).delete

				# remove orphaned tag
				if DB.from(:tags).where(tag: tag_id).empty?
					DB.from(:tag).where(id: tag_id).delete
				end
			end

			# TODO refactor
			def get_tag_id(tag)
				record = DB[:tag].where(name: tag)
				if record.empty?
					tag_id = DB[:tag].insert(name: tag)
				else
					tag_id = record.first[:id]
				end

				return tag_id
			end

			def add(file_id, tag)
				DB.from(:tags).insert_ignore.insert(file: file_id, tag: get_tag_id(tag))
			end
		end

		def self.delete(id)
			record = DB.from(:file).where(id: id)
			sha = record.first[:hash]
	
			DB.from(:tags).where(file: id).delete
			DB.from(:sequences).where(file: id).delete
			record.delete
	
			# begin
				File.delete("content/#{sha}")
				File.delete("thumbs/#{sha}")			
			# rescue => Errno::ENOENT
			# 	p "File not found"
			# end
		end
	end
end
