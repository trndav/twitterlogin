class TwitterClient
    BASE_URL = "https://api.twitter.com/2"
  
    def initialize(user)
      @user = user
    end
  
    def me
      get '/users/me'
    end

    def bookmarks 
        get "/users/#{@user.twitter_id}/bookmarks"
    end

    private 
    def get(path)
        request(:get, path)
    end
    def request(method, path, body: {})
    params = {
      method: method,
      url: "#{BASE_URL}#{path}",
      headers: headers
    }
    if method == :put || method == :post
      params[:payload] = body.to_json
      params[:headers]["Content-Type"] = "application/json"
    end

    begin
      response = RestClient::Request.execute(params)
      JSON.parse(response.body, symbolize_names: true)
    rescue => e
      Rails.logger.error e
      JSON.parse(e.response.body, symbolize_names: true)
    end
  end

  def headers
    {
      "Authorization": "Bearer #{@user.token}",

      
      "User-Agent": "RailsBookmarksSearch",
    }
  end
end