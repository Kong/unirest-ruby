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

module MashapeClient
  module HTTP
    class UrlUtils
      
      def UrlUtils.prepare_request(url, parameters, addRegularQueryStringParameters = false)
        parameters = {} if parameters.nil?
        parameters.each do |name,value|
          if value.nil?
            parameters.delete(name)
          else
            parameters[name] = value.to_s()
          end
        end
        
        finalUrl = url
        url.scan(/\{([\w\.]+)\}/) do |key|
          unless parameters.has_key?(key[0])
            finalUrl = finalUrl.gsub(/&?[\w]*=?\{#{key[0]}\}/, "");
          else
            # Url encodes the value
            finalUrl = finalUrl.gsub(/(\?.+)\{#{key[0]}\}/) { |match| $1 + CGI::escape(parameters[key[0]]) }
            finalUrl = finalUrl.gsub(/\{#{key[0]}\}/, URI.escape(parameters[key[0]]))
          end
        end
        finalUrl = finalUrl.gsub(/\?&/, "?");
        finalUrl = finalUrl.gsub(/\?$/, "");
        
        if addRegularQueryStringParameters

            uri = URI.parse(finalUrl)
            unless uri.query == nil then
              queryStringParameters = CGI.parse(uri.query)
              queryStringParameters.each_pair do |key, value|
                parameters[key] = value unless parameters.has_key?(key)
	          end
			end
        end

        return finalUrl, parameters
      end
        
      def UrlUtils.generateClientHeaders(request)
          request.add_field("User-Agent", "mashape-ruby/1.0")
          return request
      end
      
    end
  end
end
