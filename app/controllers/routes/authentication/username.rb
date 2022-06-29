class Simplepics < Sinatra::Base 
    get "/username" do
        if user_loggedin?
            return session[:user].username
        end
    end
end