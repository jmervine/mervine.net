# Use the app.rb file to load Ruby code, modify or extend the models, or
# do whatever else you fancy when the theme is loaded.
require 'ferret'

module Nesta
  class Config
    @settings += %w[ exclude_from_search ]
    def self.exclude_from_search
      from_yaml("exclude_from_search") || [ "/", "/search" ]
    end
  end

  class App
    before "/search" do
      @supress_disqus = true
    end

    before "/error/*" do
      @supress_disqus = true
    end

    # Uncomment the Rack::Static line below if your theme has assets
    # (i.e images or JavaScript).
    #
    # Put your assets in themes/rubyops/public/rubyops.
    #
    use Rack::Static, :urls => ["/rubyops"], :root => "themes/rubyops/public"

    helpers do
      def show_disqus_comment_count?(page=nil)
        return false unless Nesta::Config.disqus_short_name
        return true  unless page
        return false unless (request.path == "/" || request.path.start_with?("/archive"))
        return !(page.abspath == "/" || page.abspath.include?("archive"))
      end

      def display_searchbox
        %[<form action="/search" method="GET">
          <input type="text" name="q" value="#{params[:q]}"/>
          </form>]
      end
    end

    # Add new routes here.
    #
    # Handling legacy www.rubyops.net routes.
    get '/:year/:month/:day/:path' do
      redirect "/#{params[:path].gsub("_","-")}"
    end

    get '/tags' do
      redirect "/categories"
    end

    get '/tag/:tag' do
      begin
        if Nesta::Page.find_by_path("/"+params[:tag])
          redirect "/"+params[:tag]
        else
          redirect "/categories"
        end
      rescue
        redirect "/categories"
      end
    end

    not_found do
      @supress_disqus = true
      set_common_variables
      @page = Nesta::Page.find_by_path('/error/500')
      @title = @page.title
      haml(@page.template, :layout => @page.layout)
    end unless Nesta::App.development?

    error do
      @supress_disqus = true
      set_common_variables
      @page = Nesta::Page.find_by_path('/error/500')
      @title = @page.title
      haml(@page.template, :layout => @page.layout)
    end unless Nesta::App.development?

  end
end
