require 'util/Encryption.rb'  
  
#Oauth implementation
class OAuth
  
  def OAuth.sign(method, key, secret, uri, data = nil, timestamp = nil, nonce = nil)
    
    #constant for url_encoding
    url_unsafe = ':/=?<>+"% '

    timestamp = Time.now.to_i.to_s if timestamp.nil?
    nonce = rand(0x100000000000000000000).to_s(36) if nonce.nil?
      
    parameters = {"oauth_consumer_key" => key,
              "oauth_nonce" => nonce,
              "oauth_signature_method" => "HMAC-SHA1",
              "oauth_timestamp" => timestamp,
              "oauth_token" => "",
              "oauth_version" => "1.0"
    } 
    
    #Get the information required to build the base string for the OAuth signing
    query_string = uri.query
    uri.query = nil
    normalisedUrl = uri.to_s #default ports are removed automatically
    uri.query = query_string

    #build params - put in query/xml data if it exists
    #sort
    if (!query_string.nil?)
      queries = query_string.split('&')
      queries.each do |query|
        query = query.split('=')
        parameters[query[0]] = query[1] 
      end
    end
    
    #Assume xml data
    #parameters["xml"] = URI.escape(data, url_unsafe) if(!data.nil?)
    #parameters["xml"] = data if(!data.nil?)
    
    params_string = String.new
    parameters.sort.each do |parameter|
      params_string << parameter[0] << '%3D' << URI.escape(parameter[1], url_unsafe) << '%26'
    end
    params_string = params_string[0, params_string.length-3] #remove last extraneous %26
    
    #baseString = Method&Url&Parameters
    base = "#{method}&#{URI.escape(normalisedUrl, url_unsafe)}&#{params_string}"
    
    signature = Encoder.to_base_64(Hmac.digest(base, URI.escape(secret, url_unsafe) + '&', SHA1.new))
    
    parameters = [["oauth_consumer_key", key],
                  ["oauth_token" , ""],
                  ["oauth_nonce", nonce,],
                  ["oauth_timestamp", timestamp],
                  ["oauth_signature_method", "HMAC-SHA1"],
                  ["oauth_version" , "1.0",],
                  ["oauth_signature" , URI.escape(signature, url_unsafe)]
    ]
    
    header_value = "OAuth realm=\"#{normalisedUrl}\""
    parameters.each do |parameter|
      header_value << ",#{parameter[0]}=\"#{parameter[1]}\""
    end
    
    return {"Authorization" => header_value}
  end
  
  
end
