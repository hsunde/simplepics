class Simplepics < Sinatra::Base
	delete "/file/delete" do
		file = File_[params[:file_id]]
		sha = file[:hash]

		file.remove_all_tag
		file.delete

		begin
			File.delete("content/#{sha}")
			File.delete("thumbs/#{sha}")			
		rescue Errno::ENOENT
			p "File not found"
		end

		return 200
	end

	put "/file/tag/add" do
		file = File_[params[:file_id]]
		tag = Tag.find_or_create(name: params[:tag])
		file.add_tag(tag)

		return 200
	end

	delete "/file/tag/remove" do # post
		file = File_[params[:file_id]]
		file.remove_tag(Tag[name: params[:tag]])

		return 200
	end

	get '/file/thumb/:hash' do
		sha = params[:hash]
		path = File.exist?("thumbs/#{sha}") ? "thumbs/#{sha}" : "content/#{sha}"

		file = File.open(path)
		content_type = MimeMagic.by_magic(file).type

		send_file(file, :type => content_type)
	end

	get '/file/get/:hash' do
		sha = params[:hash]
		path = "content/#{sha}"
		content_type = MimeMagic.by_magic(File.open(path)).type

		send_file(path, :type => content_type)
	end

	get "/file/add" do
		if user_loggedin?
			erb :upload
		else
			redirect "/login"
		end
	end

	post "/file/add" do
		unless user_loggedin?
			return 403
		end

		# if params[:sequence] == 'true'
		# 	sequence = true
		# else
		# 	sequence = false
		# end

		tags = params[:tags].split(", ")
		files = params[:files]

		files.each_with_index do |file, i|
			temp = File.read(file[:tempfile])
			basename = File.basename(file[:filename], '.*')
			sha = Digest::SHA1.hexdigest(temp)
			type = file[:type].split('/')[0]

			begin
				file_record = File_.create(hash: sha, filename: basename)
				size = FastImage.size(file[:tempfile].path)
				file_record.update(x: size[0], y: size[1])

				tags.each do |tag|
					tag = Tag.find_or_create(name: tag)
					file_record.add_tag(tag)
				end

				file_record.add_tag(Tag[name: type])

				`convert "#{file[:tempfile].path}" -resize #{600}x#{600}\\> thumbs/#{sha}`
				File.write("content/#{sha}", temp)
			rescue Sequel::UniqueConstraintViolation
				p "#{basename} exists"
			end
		end

		return 200
	end	
end