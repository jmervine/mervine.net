#!/usr/bin/env ruby
%w{
css/Refresh.css
css/sunburst.css
css/active4d.css
css/all_hallows_eve.css
css/amy.css
css/blackboard.css
css/brilliance_black.css
css/brilliance_dull.css
css/cobalt.css
css/dawn.css
css/eiffel.css
css/espresso_libre.css
css/idle.css
css/iplastic.css
css/lazy.css
css/mac_classic.css
css/magicwb_amiga.css
css/pastels_on_dark.css
css/slush_poppies.css
css/spacecadet.css
css/twilight.css
css/zenburnesque.css
}.each do |css|
  puts css
  system("curl http://ultraviolet.rubyforge.org/#{css} > #{}")
end
