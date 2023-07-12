class ApplicationController < ActionController::API
    include Response

    def routing_error(error = 'Routing error', status = :not_found, exception=nil)
        json_error_response("No routes found", 404)
    end
end
