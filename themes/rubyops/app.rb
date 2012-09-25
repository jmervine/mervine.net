# Use the app.rb file to load Ruby code, modify or extend the models, or
# do whatever else you fancy when the theme is loaded.

module Nesta
  class App
    # Uncomment the Rack::Static line below if your theme has assets
    # (i.e images or JavaScript).
    #
    # Put your assets in themes/rubyops/public/rubyops.
    #
    use Rack::Static, :urls => ["/rubyops"], :root => "themes/rubyops/public"

    helpers do
      # Add new helpers here.
    end

    # Add new routes here.
    #
    # Handling legacy www.rubyops.net routes.
    get '/:year/:month/:day/:path' do
      redirect "/#{params[:path].gsub("_","-")}" 
    end

    get '/tags' do
      redirect "/"
    end

    get '/tag/:tag' do
      begin
        if Nesta::Page.find_by_path("/"+params[:tag])
          redirect "/"+params[:tag]
        else
          redirect "/"
        end
      rescue
        redirect "/"
      end
    end
  end
end
