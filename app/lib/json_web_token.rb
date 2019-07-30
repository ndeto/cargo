class JsonWebToken
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    #Expiry to 24 Hrs

    payload[:exp] = exp.to_i

    #Sign Token with appication secret

    JWT.encode(payload, HMAC_SECRET)

  end


  def decode(token)
    #From the decoded array by JWT get the payload as the first index in the array

    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body

    #rescue all errors

  rescue JWT::DecodeError => e
    #raise errors for custom handler
    raise ExceptionHandler::InvalidToken, e.message

  end
end