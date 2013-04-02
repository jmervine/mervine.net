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
    configure do
      $search_index = Ferret::Index::Index.new
      Page.find_all.each do |page|
        unless Nesta::Config.exclude_from_search.include?(page.abspath)
          $search_index << {:heading => page.heading, :href => page.abspath, :summary => page.summary, :body => page.body}
        end
      end
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

      def search_index
        $search_index
      end

      def display_searchbox
        %[<form action="/search" method="GET">
          <input type="text" name="q" value="#{params[:q]||"Search..."}"/>
          </form>]
      end
    end

    # Add new routes here.
    #
    # Handling legacy www.rubyops.net routes.
    get '/:year/:month/:day/:path' do
      redirect "/#{params[:path].gsub("_","-")}"
    end

    get '/search' do
      @results = []
      search_index.search_each("*:(#{params[:q]})") do |id, score|
        abspath = search_index[id][:href]
        @results.push(Page.find_by_path(abspath)) #unless @results.include?(Page.find_by_path(abspath))
      end

      @results.uniq!

      set_common_variables

      @page = Nesta::Page.find_by_path("/search")

      @supress_disqus = true

      haml(@page.template, :layout => @page.layout)
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
