# frozen_string_literal: true

# BEGIN

require 'forwardable'
require 'uri'

class Url
  extend Forwardable
  include Comparable

  attr_reader :query_params, :u

  def initialize(input)
    @u = case input
         when String
           @u = URI(input)
         when Url
           @u = input.u
         when URI
           @u = input
         else
           raise 'Unknown input type'
         end

    @query_params = @u.query.nil? ? {} : parse_query(@u.query)
  end

  def parse_query(query_string)
    @query_params = query_string.split('&').each_with_object({}) do |x, a|
      k, v = x.split('=')
      a[k.to_sym] = v
    end
  end

  def query_param(key, default = nil)
    query_params[key] || default
  end

  def <=>(other)
    [host, port, scheme, query_params] <=> [other.host, other.port, other.scheme, other.query_params]
  end

  def_delegators :@u, :scheme, :host, :port
  def_delegator :@u, to_s, :text_uri
end

# END
