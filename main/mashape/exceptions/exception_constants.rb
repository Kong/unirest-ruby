module MashapeClient
  module Exceptions
    
    EXCEPTION_NOTSUPPORTED_HTTPMETHOD_CODE=1003
    EXCEPTION_NOTSUPPORTED_HTTPMETHOD="HTTP method not supported, only DELETE, GET, POST, PUT are supported"
    
    EXCEPTION_SYSTEM_ERROR_CODE=2000
    EXCEPTION_INVALID_REQUEST="The API returned an invalid JSON response: %s"
    
  end
end