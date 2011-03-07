class SitemapController < ApplicationController
  caches_page :sitemap
  
  def sitemap
    headers["Content-Type"] = "text/xml"
    headers["Last-Modified"] = Time.now
  end

end
