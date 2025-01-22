# frozen_string_literal: true

require 'rack'

class AdminPolicy
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    # Реализуйте метод миддлвара. Который возвращает 403 статус ответа для всех запросов,
    # путь которых начинается с /admin.
    # Возвращать тело ответа при этом не нужно.
    req = Rack::Request.new env
    return [403, {}, ['403 Forbidden']] if req.path.start_with? '/admin'

    @app.call(env)
    # END
  end
end
