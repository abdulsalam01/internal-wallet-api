# lib/encryptor.rb
require "active_support"
require "active_support/core_ext"
require "active_support/message_encryptor"

class Encryptor
  SECRET_KEY_BASE = Rails.application.secret_key_base # You can use Rails.secret_key_base if it's available

  def initialize
    @key = ActiveSupport::KeyGenerator.new(SECRET_KEY_BASE).generate_key("encryption salt", 32)
    @crypt = ActiveSupport::MessageEncryptor.new(@key)
  end

  def encrypt(data)
    @crypt.encrypt_and_sign(data)
  end

  def decrypt(encrypted_data)
    @crypt.decrypt_and_verify(encrypted_data)
  end
end
