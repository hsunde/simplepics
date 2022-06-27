class Simplepics < Sinatra::Base
    get "/test/tags" do
        tags = get_categories()
        return tags.to_json
    end
end