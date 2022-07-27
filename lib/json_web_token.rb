module JsonWebToken
  class WebToken < ApplicationController
    SECRET_KEY = 'ewr675autdgjad136qdygaidasdad'

    def encode(payload, exp = 1.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def decode(payload)
      decoded = JWT.decode(payload, SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    end
  end
end