class UserController < ApplicationController
  def generate_token
    id = params["wallet_id"]
    encrypted = @encryptor.encrypt(id)

    render json: { data: encrypted }
  end

  def show
    price_lib = PriceRapidLib.new

    render json: { data: price_lib.get_prices([ "NIFTY 50", "BAJFINANCEEQN" ]) }
  end
end
