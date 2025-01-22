# frozen_string_literal: true

require 'rack'

class Router
  RESPONSE = {
    '/' => 'Hello, World!',
    '/about' => 'About page'
  }.freeze

  def call(env)
    # Реализуйте класс Router, который содержит обработчики для 2 маршрутов: /, /about.
    # При выполнении запросов по данным путям, возвращается строка и успешный код ответа.
    # Для всех прочих маршрутов возвращается 404 код ответа и текст.
    # BEGIN
    req = Rack::Request.new env
    if RESPONSE.key? req.path
      [200, { 'Content-Type' => 'text/html' }, [RESPONSE[req.path]]]
    else
      [404, {}, ['404 Not Found']]
    end
    # END
  end
end
