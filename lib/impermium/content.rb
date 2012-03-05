require "impermium/content/blog_post"
require "impermium/content/bookmark"
require "impermium/content/comment"
require "impermium/content/connection"

module Impermium
  module Content
    include BlogPost
    include Bookmark
    include Comment
    include Connection
    
  end
end
