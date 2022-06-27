class Simplepics < Sinatra::Base
	get '/thumb/:hash' do
		sha = params[:hash]
		path = File.exist?("thumbs/#{sha}") ? "thumbs/#{sha}" : "content/#{sha}"

		file = File.open(path)
		content_type = MimeMagic.by_magic(file).type
		# file.close()

		send_file(file, :type => content_type)
	end

	get '/get/:hash' do
		sha = params[:hash]
		path = "content/#{sha}"
		content_type = MimeMagic.by_magic(File.open(path)).type

		send_file(path, :type => content_type)
	end
end