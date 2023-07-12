module Response
  def json_response(object, status = :ok, message=nil)
    render json: {status: 200, data: object}, status: status
  end

  def json_error_response message, status = 400
  	response = {status: status, error: { message: message }}
  	render json: response, status: status
  end
end