require "impermium/content/blog_post"
require "impermium/content/bookmark"
require "impermium/content/comment"
require "impermium/content/connection"
require "impermium/content/listing"

module Impermium
  module Content
    include BlogPost
    include Bookmark
    include Comment
    include Connection
    include Listing
  end
end
