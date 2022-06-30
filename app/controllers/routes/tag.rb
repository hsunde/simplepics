class Simplepics < Sinatra::Base
    get "/tag/get" do
        return get_tags().to_json
    end

    post "/tag/add" do
        begin
            Tag.create(name: params[:tag])
        rescue Sequel::UniqueConstraintViolation
            p "Tag exists"
        end

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