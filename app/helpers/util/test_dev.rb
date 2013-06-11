require "src/xml_node"
require "src/Encryption.rb"
require 'src/o_auth.rb'
require 'src/http_requester.rb'
require 'src/schedule_viewer.rb'

require 'uri'
require "test/unit"
class TestDev < Test::Unit::TestCase
  
  def setup
    @server = '<severname>'
    @key = '<key>'
    @secret = '<sharedSecret>'
  end
  
  def test1
    #puts "Starting test 1"
    node = XmlNode.new("key1", "value1")
    assert_equal("key1", node.key)
    assert_equal("value1", node.value)
  end
  
  def test_xml_parse
    xmlString = "<root><major><minor><value>val</value><value2>val2</value2></minor><minor2>this is a node</minor2></major></root>"
    node = XmlNode.parse(xmlString)
    assert_equal("major", node.key)
    assert_equal(2, node.count)
    assert_equal("val", node.get_node(0).get_node(0).value)
    assert_equal("value", node.get_node(0).get_node(0).key)
  end
  
  def test_xml_parse_link_resolution
    xmlString = "<root><major><minor><link param1=\"value1\" param2=\"thekey\" param3=\"thevalue\"/><value>val</value><value2>val2</value2></minor><minor2>this is a node</minor2></major></root>"
    node = XmlNode.parse(xmlString)
    assert_equal("thekey", node.get_node(0).get_node("thekey").key)
    assert_equal("thevalue", node.get_node(0).get_node("thekey").value)
  end
  
  def test_sha1
    hash = "DA39A3EE5E6B4B0D3255BFEF95601890AFD80709"
    assert_equal(hash, Encoder.to_hex(SHA1.new.hash("")))
    
  end
  
  def test_hmac_sha1
    temp = "abcdefghijklmnopqrstuvwxyz1234567890"
    text1 = temp + temp + temp + temp
    hash1 = "4578b03f87fe1ec4d0d763591e1edb6313e6d194".upcase
    assert_equal(hash1, Encoder.to_hex(Hmac.digest(text1, "a", SHA1.new)))
    
    keyA = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz1234567890123"
    hashA = "bfa252ef5ba6080d2af2746ef243f9bd793740c6".upcase
    assert_equal(hashA, Encoder.to_hex(Hmac.digest("a", keyA, SHA1.new)))
    
    text2 = "1111111111111111111211111111111111111112111111111111111111121111111111111111111211111111111111111112"
    key2 = "k2RT9v0KJgrOjhBL6ASbMKv5bOjsw/do/j+DTyXfbvYYCe2i//eaEMTsZ+4ZNcMWZEMdegT5QBaHNLfY95lfjQ=="
    hash2 = "a2b2ccc88b8c7a552a0291b55278323af1501689".upcase
    assert_equal(hash2, Encoder.to_hex(Hmac.digest(text2, key2, SHA1.new)))
    
    text3 = text2
    key3 = "1111111111111111111211111111111111111112111111111111111111121111111111111111111211111111111111111112"
    hash3 = "af13aca917ed3fd166de0ebd9fd6ea7185cb14e1".upcase
    assert_equal(hash3, Encoder.to_hex(Hmac.digest(text3, key3, SHA1.new)))
  end
  #----------------------------
  def test_oauth_simple
        simple_server = 'http://test.com:80/a'
    key = 'a'
    secret = 'a'
    uri = URI.parse(simple_server)
    
    simple_header = 'OAuth realm="http://test.com/a",' + 
                  'oauth_consumer_key="a",' + 
                  'oauth_token="",' + 
                  'oauth_nonce="1",' +
                  'oauth_timestamp="1",' +
                  'oauth_signature_method="HMAC-SHA1",' +
                  'oauth_version="1.0",' + 
                  'oauth_signature="irwX5b6Qkph3wMO9QChLV%2FKI%2FzM%3D"'
                  
    simple_header2 = OAuth.sign("GET", key, secret, uri, nil, "1", "1")["Authorization"]
    assert_equal(simple_header, simple_header2)
    
   key = 'schedule'
   secret = 'a'
    
    test_header1 = 'OAuth realm="https://128.164.60.4:8443/ess/scheduleapi/v1/people",' + 
                  'oauth_consumer_key="schedule",' + 
                  'oauth_token="",' + 
                  'oauth_nonce="1",' +
                  'oauth_timestamp="1",' +
                  'oauth_signature_method="HMAC-SHA1",' +
                  'oauth_version="1.0",' + 
                  'oauth_signature="7xBK%2BxWipbjjGibb6fjaszckg6Q%3D"'
                   
    uri = URI.parse("#{@server}people")
    headerVal1 = OAuth.sign("GET", key, secret, uri, nil, "1", "1")["Authorization"]
    assert_equal(test_header1, headerVal1)
    
  end
  #----------------------------
  def test_oauth

    test_header1 = 'OAuth realm="https://128.164.60.4:8443/ess/scheduleapi/v1/people",' + 
                  'oauth_consumer_key="schedule",' + 
                  'oauth_token="",' + 
                  'oauth_nonce="1",' +
                  'oauth_timestamp="1",' +
                  'oauth_signature_method="HMAC-SHA1",' +
                  'oauth_version="1.0",' + 
                  'oauth_signature="idYtM42zKVi4Swd3n0dmplmaf04%3D"'
                   
    uri = URI.parse("#{@server}people")
    headerVal1 = OAuth.sign("GET", @key, @secret, uri, nil, "1", "1")["Authorization"]

    assert_equal(test_header1, headerVal1)

    test_header2 = 'OAuth realm="https://128.164.60.4:8443/ess/scheduleapi/v1/people",' +
                   'oauth_consumer_key="schedule",' +
                   'oauth_token="",' +
                   'oauth_nonce="1234567890",' +
                   'oauth_timestamp="1234567890",' +
                   'oauth_signature_method="HMAC-SHA1",' +
                   'oauth_version="1.0",' +
                   'oauth_signature="O1dmSlsnOqIC1b2qL6mPGguRYJw%3D"'

    headerVal2 = OAuth.sign("GET", @key, @secret, uri, nil, "1234567890", "1234567890")["Authorization"]
    assert_equal(test_header2, headerVal2)
  end
  
  def test_http_requester
    #cannot do assertion tests since nonces and timestamps are necessary
    requester = HttpRequester.new("GET", @key, @secret)
    uri = URI.parse("#{@server}people")
    puts requester.request([[uri,nil]]).inspect
  end
  
  def test_schedule_viewer
    viewer = ScheduleViewer.new(@server, @key, @secret)
    schedule = viewer.get_schedule
    puts schedule
  end
  
end
