  #Takes 2 strings, returns the digest
  #msg and key are assumed to be in ascii
  #digest is returned in hex
class SHA1

  BLOCK_SIZE = 512 
  
  def BLOCK_SIZE
    BLOCK_SIZE
  end
  
  #expects msg to be in single ascii string format
  #outputs response as single hex string  
  def hash(msg)

    #initialising SHA1 variables
    h = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0]
    
    #Pre-processing:
    #append 1 bit
    #append 0 bits until message length = 448 mod(512)
    #append length of message in binary as 64 bit big endian
    msg_bits = 8*msg.length
    msg << 0x80
    msg << 0x00 while((msg.length & 63) != 56)
    msg << [("%016X" % msg_bits)].pack("H*")

    msg = Encoder.to_32_bits(msg)
    
    #message is processed in 512bit chunks
    #input[0] is w[0], input[1] is w[1]
    #Attempting to use low storage requirement algorithm
    #S^i(X) = (X << i) OR (X >> 32-i)
    
    #16 = blocksize/wordsize since wordsize = 32, blocksize = 512
    numBlocks = msg.length/16 
    w = Array.new
    numBlocks.times do |block|
      
      16.times do |i|
        w[i] = msg[block*16+i]
      end
      
      a = h[0]; b = h[1]; c = h[2]; d = h[3]; e = h[4]
      
      80.times do |i|
        s = i&15 #MASK = 15
        if(i >= 16)
          holder = (w[(s+13)&15]^w[(s+8)&15]^w[(s+2)&15]^w[s])
          w[s] = left_c_shift(holder, 1)
        end
        
        if(i < 20)
          temp = left_c_shift(a,5) + sha1_f1(b,c,d) + e + w[s] + 0x5A827999
        elsif (i < 40)
          temp = left_c_shift(a,5) + sha1_f2(b,c,d) + e + w[s] + 0x6ED9EBA1
        elsif (i < 60)
          temp = left_c_shift(a,5) + sha1_f3(b,c,d) + e + w[s] + 0x8F1BBCDC
        else
          temp = left_c_shift(a,5) + sha1_f4(b,c,d) + e + w[s] + 0xCA62C1D6
        end
      
        e = d
        d = c
        c = left_c_shift(b, 30)
        b = a
        a = temp
      end
      
      h[0] = (h[0]+a)&0xFFFFFFFF 
      h[1] = (h[1]+b)&0xFFFFFFFF
      h[2] = (h[2]+c)&0xFFFFFFFF
      h[3] = (h[3]+d)&0xFFFFFFFF
      h[4] = (h[4]+e)&0xFFFFFFFF
    end

    #Returning in hex
    #output = ""
    #h.each do |i|
    #  output << ("%08X" % i)
    #end
    #return output
    
    #Returning in ascii
    Encoder.from_32_bits(h)
  end
  
  private
  
  def sha1_f1(b, c, d)
    ((b&c)|((~b)&d))
  end

  def sha1_f2(b,c,d)
    b^c^d
  end
  
  def sha1_f3(b,c,d)
    ((b&c)|(b&d)|(c&d))
  end
  
  def sha1_f4(b,c,d)
    b^c^d
  end
  
  def left_c_shift(val, bits)
    #Necessary to prevent numbers from getting huge and eventually getting incorrect bits shifted around
    ((val<<bits)&0xFFFFFFFF) | ((val&0xFFFFFFFF) >> (32-bits))
  end
end

class Hmac
  #message, key and hashing algorithm to use
  #expects msg and key in single ascii string
  #outputs in whatever format hashing algorithm outputs to
  def Hmac.digest(msg, key, alg)
    
    block_size = alg.BLOCK_SIZE
    
    key_bits = key.length * 8
    
    if (key_bits > block_size)
      key = alg.hash(key)
      key_bits = key.length*8
    end
    
    ((block_size-key_bits)/8).times do
      key << 0x00
    end
    
    opad = Array.new
    ipad = Array.new
    key = Encoder.to_32_bits(key) 
    key.each do |bit_chunk|
      opad << (0x5c5c5c5c ^ bit_chunk) 
      ipad << (0x36363636 ^ bit_chunk)
    end
    
    opad = Encoder.from_32_bits(opad)
    ipad = Encoder.from_32_bits(ipad)
    
    opad.concat(alg.hash(ipad.concat(msg)))
    return alg.hash(opad)
  end
end

class Encoder
  
  #Ascii to hex
  def Encoder.to_hex(msg)
    return msg.unpack('H*')[0].upcase
  end
  
  def Encoder.from_hex(msg)
    return [msg].pack('H*')
  end
  
  #ascii to base64
  def Encoder.to_base_64(msg)
    return [msg].pack("m*").chop
  end
  
  #base64 to ascii
  def Encoder.from_base_64(msg)
    return msg.unpack('m*')
  end
  
  def Encoder.to_32_bits(msg)
    return msg.unpack('N*')
  end
  
  def Encoder.from_32_bits(msg)
    return msg.pack('N*')
  end
  
end