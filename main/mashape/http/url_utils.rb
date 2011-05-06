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
      
      CLIENT_LIBRARY_LANGUAGE="RUBY"
      CLIENT_LIBRARY_VERSION="V03"
      TOKEN="_token"
      LANGUAGE="_language"
      VERSION="_version"
      
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
		queryStringParameters = CGI.parse(uri.query)
		queryStringParameters.each_pair do |key, value|
			parameters[key] = value unless parameters.has_key?(key)
		end

	end

        return finalUrl, parameters
      end
      
      def UrlUtils.add_client_parameters(url, parameters, token)
        parameters = {} if parameters.nil?
        
        url.include?("?") ? url << "&" : url << "?"
        
        url << self.add_client_parameter(TOKEN)
        parameters[TOKEN] = token
        url << "&" << self.add_client_parameter(LANGUAGE)
        parameters[LANGUAGE] = CLIENT_LIBRARY_LANGUAGE
        url << "&" << self.add_client_parameter(VERSION)
        parameters[VERSION] = CLIENT_LIBRARY_VERSION
        
        return url, parameters
      end
      
      private
      
      def UrlUtils.add_client_parameter(parameter)
        return parameter + "={" + parameter + "}"
      end
      
    end
  end
end
