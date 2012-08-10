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

require 'cgi'
require 'uri'
require 'base64'
require 'hmac-sha1'

module MashapeClient
  module HTTP
    class AuthUtil
      
      def AuthUtil.generateMashapeAuthHeader(public_key, private_key)
        unless public_key.empty? || private_key.empty?
          hash = HMAC::SHA1.hexdigest(private_key, public_key)
          auth = {"X-Mashape-Authorization" => Base64.encode64(public_key + ":" + hash).chomp.gsub(/\n/,'')}
        end
        return auth
      end
      
      def AuthUtil.generateBasicAuthHeader(username, password)
        unless username.empty? || password.empty?
          auth = {"Authorization" => "Basic " + Base64.encode64(username + ":" + password).chomp.gsub(/\n/,'')}
        end
        return auth
      end
 
    end
  end
end
