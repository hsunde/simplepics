module Upload
	def self.generate_thumb(path, sha, type)
		size = 600
		
		if type == "image"
			`convert "#{path}" -resize #{size}x#{size}\\> thumbs/#{sha}`
		elsif type == "video"
			duration = `ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "#{path}"`.strip.to_i
			`ffmpeg -y -ss #{duration / 2} -i '#{path}' -vf "scale='min(#{size},iw)':min'(#{size},ih)':force_original_aspect_ratio=decrease,crop=trunc(iw/2)*2:trunc(ih/2)*2" -frames:v 1 -f image2 thumbs/#{sha}`
		end
	end
	
    def self.add(sequence, tags, files)
		if sequence
			max_sequence = DB[:sequences].max(:sequence)
		end

		tags = tags.split(', ')

		files.each_with_index do |file, i|
			temp = File.read(file[:tempfile])
			basename = File.basename(file[:filename], '.*')
			sha = Digest::SHA1.hexdigest(temp)
			type = file[:type].split('/')[0]

			record = DB[:file].where(hash: sha).first

			unless record
				size = FastImage.size(file[:tempfile].path)
				file_id = DB[:file].insert(hash: sha, filename: basename, x: size[0], y: size[1])
				
				tags.each do |tag|
					record = DB[:tag].where(name: tag).first

					if record
						tag_id = record[:id]
					else
						tag_id = DB[:tag].insert(name: tag)
					end

					DB[:tags].insert(file: file_id, tag: tag_id)
				end

                if type
					tag_id = DB[:tag].where(name: type).first[:id]
					DB[:tags].insert(file: file_id, tag: tag_id)	
				end

				if sequence
					DB[:sequences].insert(file: file_id, sequence: max_sequence.to_i + 1, order: i + 1)
				end

				generate_thumb(file[:tempfile].path, sha, type)
				File.write("content/#{sha}", temp)
			else
				p "#{basename} exists"
			end
		end
    end
end
