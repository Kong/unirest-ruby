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

require File.join(File.dirname(__FILE__), "/../init/init.rb")

class UrlUtils
  
  def UrlUtils.addRouteParameter(url, parameterName)
    result = url
    if (result.split("?").size < 2)
      result += "?"
    end
    if (result[result.size - 1, result.size] != "?")
      result += "&"
    end
    result += parameterName + "={" + parameterName + "}"
    return result
  end
  
  def UrlUtils.addClientParameters(url)
    result = UrlUtils.addRouteParameter(url, ClientInfo::TOKEN)
    result = UrlUtils.addRouteParameter(result, ClientInfo::LANGUAGE)
    result = UrlUtils.addRouteParameter(result, ClientInfo::VERSION)
    return result
  end
  
  def UrlUtils.getCleanUrl(url, parameters)
    if (parameters.nil?)
      parameters = {}
    end
    finalUrl = ""
    newpos = -1
    (0..url.size-1).each do |i|
      if (newpos >= i)
        next
      end
      curchar = url[i]
      if (curchar == "{")
        # It may be a placeholder
        
        pos = url.index("}", i)
        if (pos != nil)
          # It's a placeholder
          
          placeHolder = url[i + 1, pos - i - 1]
          if (parameters.has_key?(placeHolder) == false)
            # If it doesn't exist in the array, remove it
            newpos = pos
            if (url[i -1] == "=")
              # It's a query string placeholder, remove also its name
              
              (finalUrl.size - 1).downto(0) { |t| 
              
                backChar = finalUrl[t]
                if (backChar == "?" || backChar == "&")
                  finalUrl = finalUrl[0, backChar == "?" ? t + 1 : t]
                  break
                end
              
              }
                
            end
            
            next
            
          end
        end
      end
      finalUrl += curchar    
    end
    return finalUrl.gsub("?&", "?")
  end
  
  def UrlUtils.getQueryStringParameters(url)
    result = Hash.new()
    urlParts = url.split("?")
    if (urlParts.size > 1)
      queryString = urlParts[1]
      queryString.split("&").each {|p|
      
        parameter = p.split("=")
        if (parameter.size > 1)
          if (UrlUtils.isPlaceHolder(parameter[1]) == false)
            result[parameter[0]] = parameter[1]
          end
        end
      }
      
    end
    return result
  end
  
  def UrlUtils.isPlaceHolder(value)
    if (value.size >= 2)
      if (value[0] == "{" && value[(value.size - 1)] == "}")
        return true;
      end
    end
    return false;
  end
  
  def UrlUtils.removeQueryString(url)
    return url.split("?")[0]
  end
  
end


