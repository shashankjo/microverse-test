module Api
  class FetchUsers
    def initialize
      @key      = "An32iK-eRu17"  # TODO : move this API key to env file outside the code
      @domain   = "https://microverse-api-app.herokuapp.com/users"
      @logger   = Logger.new(STDOUT)
    end

    def call
      response  = HTTParty.get("#{@domain}", headers: headers)
      response
    rescue HTTParty::Error, HTTParty::ResponseError => e
      log_error(e)
    end

    def headers
      {
        "Authorization": @key
      }
    end

    private

    def log_error(error)
      @logger.error(error.message)
      @logger.error(error.backtrace.join("\n"))
    end
  end
end
