#--
# Mashape Ruby Client library.
#
# Copyright (C) 2011 Mashape, Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
#
# The author of this software is Mashape, Inc.
# For any question or feedback please contact us at: support@mashape.com
#++

require 'net/http'
require 'net/https'
require 'uri'
require 'cgi'
require "rubygems"
require 'json'
require File.join(File.dirname(__FILE__), "/../init/init.rb")
require File.join(File.dirname(__FILE__), "/../exceptions/mashapeClientException.rb")

class HttpClient

  METHOD="_method"
  TOKEN="_token"
  LANGUAGE="_language"
  VERSION="_version"
  def HttpClient.doCall(baseUrl, httpMethod, method, token, parameters)

    if parameters.nil?
      parameters = Array.new()
    else
      # Remove null parameters
      parameters.each do |name,value|
        if value.nil?
          parameters.delete(name)
        else
          parameters[name] = value.to_s()
        end
      end
    end

    parameters[METHOD] = method;
    parameters[TOKEN] = token;
    parameters[LANGUAGE] = ClientInfo::CLIENT_LIBRARY_LANGUAGE;
    parameters[VERSION] = ClientInfo::CLIENT_LIBRARY_VERSION;

    response = ""

    begin
      case httpMethod
      when :get
        response = HttpClient.doGet(baseUrl, parameters);
      when :post
        response = HttpClient.doPost(baseUrl, parameters);
      when :put
        response = HttpClient.doPut(baseUrl, parameters);
      when :delete
        response = HttpClient.doDelete(baseUrl, parameters);
      else
        raise MashapeClientException.new(ExceptionMessages::EXCEPTION_NOTSUPPORTED_HTTPMETHOD, ExceptionMessages::EXCEPTION_NOTSUPPORTED_HTTPMETHOD_CODE)
      end
    rescue StandardError
      response = ""
    end

    if response.empty?
      raise MashapeClientException.new(ExceptionMessages::EXCEPTION_EMPTY_REQUEST, ExceptionMessages::EXCEPTION_SYSTEM_ERROR_CODE)
    end

    begin
      responseObject = JSON.parse(response)
    rescue StandardError
      raise MashapeClientException.new(ExceptionMessages::EXCEPTION_INVALID_REQUEST, ExceptionMessages::EXCEPTION_SYSTEM_ERROR_CODE)
    end

    return responseObject

  end

  def HttpClient.doGet(url, parameters)
    queryString = ""
    unless parameters.empty?
      parameters.each do |name,value|
        queryString +="&" unless queryString.empty?
        queryString += name + "=" + CGI::escape(value)
      end
    end

    uri = URI.parse(url + "?" + queryString)
    http = Net::HTTP.new(uri.host, uri.port)
    if uri.port == 443
      http.use_ssl = true
    end
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    return response.body
  end

  def HttpClient.doPost(url, parameters)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    if uri.port == 443
      http.use_ssl = true
    end
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(parameters)
    response = http.request(request)
    return response.body
  end

  def HttpClient.doPut(url, parameters)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    if uri.port == 443
      http.use_ssl = true
    end
    request = Net::HTTP::Put.new(uri.request_uri)
    request.set_form_data(parameters)
    response = http.request(request)
    return response.body
  end

  def HttpClient.doDelete(url, parameters)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    if uri.port == 443
      http.use_ssl = true
    end
    request = Net::HTTP::Delete.new(uri.request_uri)
    request.set_form_data(parameters)
    response = http.request(request)
    return response.body
  end

end
