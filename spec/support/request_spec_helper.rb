module RequestSpecHelper

  # create a JSON helper
  def json
    JSON.parse(response.body)
  end

end