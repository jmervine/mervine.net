# Use the app.rb file to load Ruby code, modify or extend the models, or
# do whatever else you fancy when the theme is loaded.

module Nesta
  class App
    use Rack::Static, :urls => ["/original"], :root => "themes/original/public"

    helpers do
      # Add new helpers here.
    end
  end
end

