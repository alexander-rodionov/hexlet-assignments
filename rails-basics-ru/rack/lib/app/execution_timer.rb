# frozen_string_literal: true

require 'rack'
require 'time'

class ExecutionTimer
  def initialize(app)
    @app = app
    @start = nil
  end
  # Реализуйте и подключите на страницу миддлвар, который выводит информацию о затраченном времени выполнения сайта
  # в микросекундах. При этом хеш контента не должен измениться.

  def start_timer
    @start = Time.now.to_f
  end

  def stop_timer
    current_time = Time.now.to_f
    delta = current_time - @start
    (10**6) * (delta - delta.truncate)
  end

  def call(env)
    start_timer
    status, header, body = @app.call env
    [status, header, [*body, stop_timer.to_s]]
  end
end
