#$:.unshift File.join(File.dirname(__FILE__), 'util')

require 'net/https'
require 'util/xml_node.rb'
require 'util/o_auth.rb'

class HttpRequester
  
  def initialize(method = "GET", key = "", secret = "")
    @method = method
    @key = key
    @secret = secret
  end
  
  #assumes input is an array of nested uri_data arrays
  #eg . [[uri1, data1], [uri2, data2], ... [uri_n, data_n]]
  #returns array of xmlNodes [tree1, tree2, ...]
  #uses request_raw to get the responses
  def request(uris_data)

    #Setup output array
    xmlNodes = Array.new
    responses = request_raw(uris_data)
    
    responses.each do |response|
      if (response.code == "200")
        response.body.empty? ? (xmlNodes << XmlNode.new("Empty")) : xmlNodes << XmlNode.parse(response.body)
      else
        xmlnode = XmlNode.new("error")
        xmlnode.put_node('code', response.code) #put status code as xmlnode
        xmlnode.put_node('msg', response.body)
        xmlNodes << xmlnode
      end
    end
    return xmlNodes
  end
  
  #Returns the entire response without any parsing
  def request_raw(uris_data)
    
    http = setup_https(uris_data[0][0])
    
    #Setup output array
    responses = Array.new
    
    uris_data.each do |uri_data|
      headers = OAuth.sign(@method.upcase, @key, @secret, uri_data[0], uri_data[1])
      (uri_data[0].query.nil?) ? (query = "") : (query = "/" + uri_data[0].query)
      headers['Content-Type'] = 'application/xml'
      resp = http.send_request(@method, uri_data[0].path + query, uri_data[1], headers)
      responses << resp
    end
    return responses
  end
  
  def HttpRequester.url_unsafe
    ':/=?<>+"%'
  end
  
  private
  
  def setup_https(uri)
    #Assume all requests are going to the same server/port
    http = Net::HTTP.new(uri.host, uri.port)
    #Setup for https and allow all hosts
    if uri.scheme == "https"
      http.use_ssl = true 
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    
    return http
  end
  
end
