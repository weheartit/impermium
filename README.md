# Impermium #

Ruby wrapper for the [Impermium API](http://impermium.com).

* gem version 1.0.0 supports the Impermium API version 3.1

## Usage ##

In order to use Impermium gem you must get an Impermium API key.

### Instantiate and configure a client ###

The Impermium client can be instantiated and configured in several ways. A new client can be created with

    client = Impermium.new(:api_key => <your_api_key>)

which is actually short way of 

    client = Impermium::Client.new(:api_key => <your_api_key>)

Constructor accepts a hash of options that can be used to configure the Impermium client. Valid hash keys are

* `:adapter` (sets Faraday adapter)
* `:api_version` (sets Impermium API version - default 3.1)
* `:api_key` (sets API key)
* `:client_name` (sets client name)
* `:client_id` (sets client ID)
* `:endpoint` (sets URL to Impermium server - default http://api.impermium.com)

Either of these values can be set directly too:

* client = Impermium.new
* client.api_key = <your_api_key>
* client.endpoint = "http://api-test.impermium.com"

Finally, Impermium client can be configured through a block with:

    Impermium.configure do |conf|
      conf.api_key = <your_api_key>
      conf.endpoint = "http://api-test.impermium.com"
    end

    client = Impermium.new

### Calling API methods  ###

Each method accepts the mandatory arguments of the correspondent API call, and have an options hash and a block as optional arguments. Here is the list of all supported methods and their mandatory arguments:
 
* __USER__
    + __Account:__
      - `client.account(user_id, enduser_ip)`
      - `client.account_attempt(enduser_ip)`
      - `client.account_login(user_id, enduser_ip)`
      - `client.account_analyst_feedback(analyst_id, user_id, desired_result)`
      - `client.account_user_feedback(rep_usr_id, rep_usr_type, reporter_ip, user_id, desired_result)`
      
    + __Profile:__
      - `client.profile(user_id, profile_id, enduser_ip)`
      - `client.profile_analyst_feedback(profile_id, analyst_id, desired_result)`
      - `client.profile_user_feedback(profile_id, rep_usr_id, rep_usr_type, reporter_ip, desired_result)`

* __CONTENT__
    + __Blog post:__
      - `client.blog_post(user_id, blog_post_id, content, blog_post_permalink, blog_url, enduser_ip)`
      - `client.blog_post_analyst_feedback(analyst_id, blog_post_id, desired_result)`
      - `client.blog_post_user_feedback(rep_usr_id, rep_usr_type, reporter_ip, blog_post_id, desired_result)`
  
    + __Bookmark:__
      - `client.bookmark(user_id, bookmark_id, bookmark_url, enduser_ip)`
      - `client.bookmark_like(user_id, bookmark_id, bookmark_url, like_value, enduser_ip)`
      - `client.bookmark_analyst_feedback(analyst_id, bookmark_id, desired_result)`
      - `client.bookmark_user_feedback(rep_usr_id, rep_usr_type, reporter_ip, bookmark_id, desired_result)`
      
    + __Comment:__
      - `client.comment(user_id, comment_id, content, comment_permalink, article_permalink, enduser_ip)`
      - `client.comment_analyst_feedback(analyst_id, comment_id, desired_result)`
      - `client.comment_user_feedback(rep_usr_id, rep_usr_type, reporter_ip, comment_id, desired_result)`
      
    + __Connection:__
      - `client.connection(operation, connection_type, connection_id, requester_user_id, responder_user_id, enduser_ip)`
      - `client.connection_analyst_feedback(analyst_id, connection_type, connection_id, desired_result)`
      - `client.connection_user_feedback(rep_usr_id, rep_usr_type, reporter_ip, connection_type, connection_id, desired_result)`
      
    + __Listing:__
      - `client.listing(user_id, listing_id, content, listing_permalink, enduser_ip)`
      - `client.listing_analyst_feedback(analyst_id, listing_id, desired_result)`
      - `client.listing_user_feedback(rep_usr_id, rep_usr_type, reporter_ip, listing_id, desired_result)`

Additional arguments can be passed through the hash which is the last argument for every method

    client.account('33', '255.255.255.255', {:alias => "user33", :password_hash=>'7d222a5d269a'})

If request headers have to be set it can be done through block

    Impermium.account('33', '255.255.255.255') do |req|
      req.headers = {:http_user_agent => "Impermium gem 1.0.0"}
    end

You can find the complete arguments lists and types in the official Impermium API docs site.

### Responses ###

Any method call receiving a successful response from impermium API will return a Hash like structure containing the body of the response, typically including `response_id`, `timestamp` and posibly `spam_classifier` and any other additional classifiers.

Any 4XX response will raise an Impermium Exception with the body of the response in the error message.

* A 400 status response from the impermium API will raise an `Impermium::BadRequest`
* A 401 status response from the impermium API will raise an `Impermium::UnauthorizedRequest`
* A 403 status response from the impermium API will raise an `Impermium::ForbiddenRequest`
* A 404 status response from the impermium API will raise an `Impermium::NotFoundRequest`

## Credits ##

Here is the [list of contributors](https://github.com/weheartit/impermium/contributors).

## License ##

Copyright 2012 WHI Inc. ([weheartit.com](http://weheartit.com)), released under the MIT license.