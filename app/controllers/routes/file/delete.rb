class Simplepics < Sinatra::Base
	post "/edit/delete" do
		ContentFile::delete(params[:file_id])
	end
end