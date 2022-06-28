class Simplepics < Sinatra::Base 
    get "/username" do
        if user_loggedin?
            session[:user].username
        end
    end
end