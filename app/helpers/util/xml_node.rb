class XmlNode
  
  #Todo: have to convert all - in keys
  # to _ 

  attr_accessor :key, :value, :parent
  def initialize(key, val = nil, parent = nil)
    @key = key.gsub('-', '_')
#    @key = key
    @value = val
    @parent = parent
    @children = Array.new
    @is_leaf = !value.nil?
  end
  
  #----Basic Methods----#
  def put_node(node, value = nil)
    if (String === node)
      @children << XmlNode.new(node, value, self)
    elsif(XmlNode === node)
      node.parent=self
      @children << node
    end
    return @children.last
  end
  
  def get_node(i = 0)
    if(Integer === i)
      return @children[i]
    else
      #get by key
      @children.each do |child|
        return child if (child.key == i)
      end
    end
    return nil
  end

  def remove_node(i)
    @children.delete_at(i)
  end
  
  def value=(val)
    @value = val
    @is_leaf = !val.nil?
  end
  
  def is_leaf?
    return @is_leaf
  end

  def XmlNode.header
    return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
  end

  def xml
    return XmlNode.header + self.inspect
  end

  #----End Basic Methods----#

  #----Overriden methods----#
  def inspect
      line = "<#{@key.gsub('_', '-')}>"
      if (is_leaf?)
        line << @value
      else
        @children.each do |child|
          line << child.inspect
        end
    end
    line << "</#{@key.gsub('_', '-')}>"
  end
  
  def inspect_
    line = "<#@key>"
      if (is_leaf?)
        line << @value
      else
        @children.each do |child|
          line << child.inspect_
        end
    end
    line << "</#@key>"
  end
  
  def count
    @children.length
  end
  
  def each
    @children.each do |i|
      yield i
    end
  end

  #----End Overriden methods----#
  
  #----Complex Methods----#
  def XmlNode.parse(xml)
    
    tokens = XmlNode.xmlSplit(xml)
    
    tree = XmlNode.new(tokens[0][1])
    root = tree
    tokens.delete_at(0)
    
    tokens.each do |token|
      case token[0]
        when :open then
          tree = tree.put_node(token[1]) 
        when :close then
          tree = tree.parent
        when :pair then
          tmp = token[1]
          tree.put_node(tmp[0,tmp.index(' ')], tmp[tmp.index(' ')+1, tmp.length])
        when :value then
          tree.value = token[1]
        when :solo_tag then
          tree.put_node(token[1])
      end
    end
    
    root = root.get_node(0)
    3.times {root.remove_node(0) } if (root.get_node(0).key.eql?("total_results"))
    
    root.resolveLinks
  end
    
  def resolveLinks
    @children.each do |child| 
      if(child.is_leaf?)
        if(child.key == "link")
          tokens = child.value.split(/ |=/) #using reg-exp more
          child.key = tokens[3][1, tokens[3].length-2].gsub('-', '_')
          child.value = tokens[5][1, tokens[5].length-2]
          #tokens = child.value.split(/ /)
          #child.key = tokens[1][7,tokens[1].length-1]
          #child.value = tokens[2][6, tokens[2].length-1]
        end
      else
        child.resolveLinks
      end
   end
   return self
  end
  #----End Complex Methods----#

  #----Private methods----#
  private
  
  def XmlNode.xmlSplit(xml)

    big_tokens = xml.split('<')
    big_tokens.delete_at(0) #first element is empty string
    ret = Array.new
    big_tokens.each do |big_token|
      tokens = big_token.split('>')

      if(tokens.length == 1)
        #either an opening xml tag, closing tag or mixed key, val tag
        if(big_token[0] == ?/) #closing tag e.g. </div>
          ret << [:close, big_token[1,big_token.length-2]]
        elsif (big_token[-2,1] == '/') #key,val pair (solo_tag with attributes) or solo_tag
          split_by_spaces = big_token.split(' ')
          if ((split_by_spaces.length == 1) || 
              (big_token.split(' ')[1] == '/')) #solo_tag e.g <br />
            ret << [:solo_tag, split_by_spaces[0]]
          else #key,val pair e.g. <tag_name class="a class"/>
            ret << [:pair, big_token[0, big_token.length-2]]
          end
        else #opening tag e.g. <div>
          ret << [:open, big_token.chop]
          
        end
      else #only other possibility is size 2, which means first half is key, second is value
        ret << [:open, tokens[0]]
        ret << [:value, tokens[1]]
      end
    end
    return ret
  end
  
end
