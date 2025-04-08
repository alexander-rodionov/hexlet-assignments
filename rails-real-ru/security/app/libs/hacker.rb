# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'net/https'

class Hacker
  TARGET_URL = 'https://rails-collective-blog-ru.hexlet.app'
  REGISTER_GET = 'https://rails-collective-blog-ru.hexlet.app/users/sign_up'
  USERS_POST = 'https://rails-collective-blog-ru.hexlet.app/users'

  HOME_URI = URI.parse(TARGET_URL)
  REG_GET_URI = URI.parse(REGISTER_GET)
  REG_CREATE_URI = URI.parse(USERS_POST)

  class << self
    def hack(email, password)
      p email, password

      WebMock.allow_net_connect!
      res = do_get(TARGET_URL, '/users/sign_up')
      html = Nokogiri::HTML(res.body)

      x_csrf_token = html.css('html head meta[name=csrf-token]').first['content']
      cookie = res.to_hash['set-cookie']

      p params = {
        'authenticity_token' => x_csrf_token,
        'user[email]' => email,
        'user[password]' => password,
        'user[password_confirmation]' => password,
        'commit' => 'Регистрация'
      }

      headers = {
        'cookie' => cookie
      }

      res = do_post(TARGET_URL, '/users', params, headers)
      resp_body = res.body.force_encoding('UTF-8')
      p '-' * 80
      p res
      pp Nokogiri::HTML(resp_body).text

      WebMock.disable_net_connect!
      true
    end

    def do_get(uri_path, method)
      uri = URI(uri_path)
      Net::HTTP.start(uri.host, uri.port,
                      use_ssl: uri.scheme == 'https',
                      verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
        request = Net::HTTP::Get.new uri.request_uri + method
        http.request request
      end
    end

    def do_post(uri_path, method, params, headers)
      uri = URI(uri_path)
      Net::HTTP.start(uri.host, uri.port,
                      use_ssl: uri.scheme == 'https',
                      verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
        request = Net::HTTP::Post.new uri.request_uri + method
        headers.each { |k, v| request[k] = v }
        request.set_form_data(params)
        headers['content-type'] = 'application/x-www-form-urlencoded;charset=UTF-8'
        p request.body
        http.request request
      end
    end
  end
end
