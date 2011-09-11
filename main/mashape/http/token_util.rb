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

require File.join(File.dirname(__FILE__), "/http_client.rb")

module MashapeClient
  module HTTP
    class TokenUtil
      
      TOKEN_URL="https://api.mashape.com/requestToken"
      
      def TokenUtil.request_token(developer_key)
        
        parameters = {"devkey" => developer_key}
        json_response = MashapeClient::HTTP::HttpClient.do_request(:post, TOKEN_URL, parameters, nil)
        
        error = json_response["error"]
        if error == nil
          return json_response["token"]
        else
          raise MashapeClient::Exceptions::MashapeClientException.new(error["message"], error["code"])
        end
      end
      
    end
  end
end
