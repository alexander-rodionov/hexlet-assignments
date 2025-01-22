# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    # Реализуйте метод миддлвара, который добавляет в тело ответа хеш, зашифрованный по алгоритму семейства SHA-256

    status, headers, body = @app.call(env)
    body << (Digest::SHA256.hexdigest body[0])
    [status, headers, body]
    # END
  end
end
