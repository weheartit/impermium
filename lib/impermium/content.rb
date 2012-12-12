require "impermium/content/blog_post"
require "impermium/content/url"
require "impermium/content/comment"
require "impermium/content/connection"
require "impermium/content/listing"

module Impermium
  module Content
    include BlogPost
    include URL
    include Comment
    include Connection
    include Listing
  end
end
