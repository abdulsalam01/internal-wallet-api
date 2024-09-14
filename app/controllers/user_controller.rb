class UserController < ApplicationController
  def generate_token
    id = params["wallet_id"]
    encrypted = @encryptor.encrypt(id)

    render json: { data: encrypted }
  end
end
