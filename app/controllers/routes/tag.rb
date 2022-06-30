class Simplepics < Sinatra::Base
    get "/tag/get" do
        return get_tags().to_json
    end

    post "/tag/add" do
        Tag.find_or_create(name: params[:tag])

        return 200
    end

    post "/tag/change_category" do
        tag = Tag[name: params[:tag]]  
        category = TagCategory[name: params[:category]]
    end

    delete "/tag/delete" do
        tag = Tag[name: params[:tag]]
        tag.remove_all_file
        tag.delete
    end
end