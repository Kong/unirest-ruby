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
require 'uri'
require "rubygems"
require 'json'
require File.join(File.dirname(__FILE__), "/httpClient.rb")
require File.join(File.dirname(__FILE__), "/../exceptions/mashapeClientException.rb")

class TokenUtil

  TOKEN_URL="https://api.mashape.com/requestToken"
  def TokenUtil.requestToken(apiKey)
    parameters = {"apikey" => apiKey}
    data = HttpClient.doPost(TOKEN_URL, parameters);

    result = JSON.parse(data)
    errors = result["errors"]
    if errors.empty?
      return result["token"]
    else
      raise MashapeClientException.new(errors[0]["message"], errors[0]["code"])
    end
  end

end
