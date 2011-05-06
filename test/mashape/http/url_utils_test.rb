require 'test/unit'
require File.join(File.dirname(__FILE__), "/../../../main/mashape/http/url_utils.rb")

class StringTest < Test::Unit::TestCase
  
  def test_prepare_request
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com", nil)
    assert_equal("http://www.ciao.com", url)
    assert_equal({}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com", {})
    assert_equal("http://www.ciao.com", url)
    assert_equal({}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}", nil)
    assert_equal("http://www.ciao.com/", url)
    assert_equal({}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}", nil)
    assert_equal("http://www.ciao.com/", url)
    assert_equal({}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}", {'id'=>'12'})
    assert_equal("http://www.ciao.com/12", url)
    assert_equal({'id'=>'12'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}", {'id'=>'12', 'name'=>'tom'})
    assert_equal("http://www.ciao.com/12?name=tom", url)
    assert_equal({'id'=>'12', 'name'=>'tom'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}&opt=1", {'id'=>'12', 'name'=>'tom'})
    assert_equal("http://www.ciao.com/12?name=tom&opt=1", url)
    assert_equal({'id'=>'12', 'name'=>'tom'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}&opt=1", {'id'=>'12', 'name'=>'tom jerry'})
    assert_equal("http://www.ciao.com/12?name=tom+jerry&opt=1", url)
    assert_equal({'id'=>'12', 'name'=>'tom jerry'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}&opt=1&nick={nick}", {'id'=>'12', 'name'=>'tom jerry'})
    assert_equal("http://www.ciao.com/12?name=tom+jerry&opt=1", url)
    assert_equal({'id'=>'12', 'name'=>'tom jerry'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}&opt={opt}&nick={nick}", {'id'=>'12', 'name'=>'tom jerry', 'nick'=>'sinz'})
    assert_equal("http://www.ciao.com/12?name=tom+jerry&nick=sinz", url)
    assert_equal({'id'=>'12', 'name'=>'tom jerry', 'nick'=>'sinz'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}&opt={opt}&nick={nick}", {'id'=>'12', 'name'=>'tom jerry', 'opt'=>'yes', 'nick'=>'sinz'})
    assert_equal("http://www.ciao.com/12?name=tom+jerry&opt=yes&nick=sinz", url)
    assert_equal({'id'=>'12', 'name'=>'tom jerry', 'opt'=>'yes', 'nick'=>'sinz'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}&opt={opt}&nick={nick}", {'id'=>'12', 'opt'=>'yes', 'nick'=>'sinz'})
    assert_equal("http://www.ciao.com/12?opt=yes&nick=sinz", url)
    assert_equal({'id'=>'12', 'opt'=>'yes', 'nick'=>'sinz'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}&opt={opt}&nick={nick}", {'id'=>'12', 'opt'=>'yes'})
    assert_equal("http://www.ciao.com/12?opt=yes", url)
    assert_equal({'id'=>'12', 'opt'=>'yes'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}&opt={opt}&nick={nick}", {'id'=>'12', 'nick'=>'sinz'})
    assert_equal("http://www.ciao.com/12?nick=sinz", url)
    assert_equal({'id'=>'12', 'nick'=>'sinz'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}&opt={opt}&nick={nick}", {'id'=>'12'})
    assert_equal("http://www.ciao.com/12", url)
    assert_equal({'id'=>'12'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}&opt={opt}&nick={nick}", {'id'=>'12', 'pippo'=>nil})
    assert_equal("http://www.ciao.com/12", url)
    assert_equal({'id'=>'12'}, parameters)

    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}&opt={opt}&nick=some+nick", {'id'=>'ciao marco', 'name'=>'ciao pippo', 'opt' => '2'})
    assert_equal("http://www.ciao.com/ciao%20marco?name=ciao+pippo&opt=2&nick=some+nick", url)
    assert_equal({'id'=>'ciao marco', 'name'=>'ciao pippo', 'opt' => '2'}, parameters)

    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request("http://www.ciao.com/{id}?name={name}&opt={opt}&nick=some+nick", {'id'=>'ciao marco', 'name'=>'ciao pippo', 'opt' => '{this is opt}'})
    assert_equal("http://www.ciao.com/ciao%20marco?name=ciao+pippo&opt=%7Bthis+is+opt%7D&nick=some+nick", url)
    assert_equal({'id'=>'ciao marco', 'name'=>'ciao pippo', 'opt' => '{this is opt}'}, parameters)

  end
  
  def test_add_client_parameters
    url, parameters = MashapeClient::HTTP::UrlUtils.add_client_parameters("http://www.ciao.com", nil, nil)
    assert_equal("http://www.ciao.com?_token={_token}&_language={_language}&_version={_version}", url)
    assert_equal({'_token'=>nil, '_language'=>'RUBY', '_version'=>'V03'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.add_client_parameters("http://www.ciao.com?name={name}", {'name'=>'Marco'}, nil)
    assert_equal("http://www.ciao.com?name={name}&_token={_token}&_language={_language}&_version={_version}", url)
    assert_equal({'name'=>'Marco', '_token'=>nil, '_language'=>'RUBY', '_version'=>'V03'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.add_client_parameters("http://www.ciao.com?name={name}", {'name'=>'Marco'}, 'a-random-token')
    assert_equal("http://www.ciao.com?name={name}&_token={_token}&_language={_language}&_version={_version}", url)
    assert_equal({'name'=>'Marco', '_token'=>'a-random-token', '_language'=>'RUBY', '_version'=>'V03'}, parameters)
    
    url, parameters = MashapeClient::HTTP::UrlUtils.add_client_parameters("http://www.ciao.com?name={name}", {'name'=>'Marco'}, 'a-random-token')
    url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request(url, parameters)
    assert_equal("http://www.ciao.com?name=Marco&_token=a-random-token&_language=RUBY&_version=V03", url)
    assert_equal({'name'=>'Marco', '_token'=>'a-random-token', '_language'=>'RUBY', '_version'=>'V03'}, parameters)
  end
  
end
