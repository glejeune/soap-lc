class String #:nodoc:
  def nns
    self.gsub( /^[^:]*:/, "" )
  end
end

class Hash #:nodoc:
  def keys_to_sym!( )
    self.each {|k, v| 
      self.delete(k)
      self[k.to_sym] = v
    }
  end

  def kvTable( k, v )
    self[k] = v
#    if( self.keys.include?(k) )
#      if self[k].class == Array
#        self[k] << v
#      else
#        self[k] = [self[k], v]
#      end
#    else
#      self[k] = v
#    end
  end  
end

