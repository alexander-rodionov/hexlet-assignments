# frozen_string_literal: true

class TableWrapper
  PAGE_PREFIX = '<HTML><BODY><TABLE>'
  PAGE_POSTFIX = '</TABLE></BODY></HTML>'
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call env
    return [status, headers, body] if status != 200

    res = PAGE_PREFIX
    res += body.reduce('') { |a, x| a + "<tr><td>#{x}</td></tr>" }
    res += PAGE_POSTFIX
    [status, headers, res]
  end
end
