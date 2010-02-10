module SOAP
  class WSDL
    class Bindings < Hash
      def getBindingForOperationName( binding, name )
        r = []
        if binding.nil?        
          self.each do |binding_name, binding|
            r << binding if binding.operations.keys.include?(name)
          end
        else
          r << self[binding] if self[binding].operations.keys.include?(name)
        end
        return r
      end
      
      def getOperations( binding = nil )
        r = []
        if binding.nil?        
          self.each do |binding_name, binding|
            r = r + binding.operations.keys
          end
        else
          r = r + self[binding].operations.keys
        end
        return r
      end
    end
    
    class Binding
      attr_reader :operations
      attr_reader :name
      attr_reader :type
      attr_reader :style
      attr_reader :transport
      
      def initialize( element )
        @operations = Hash.new
        @name = element.attributes['name']
        @type = element.attributes['type'] # because of Object#type
        @style = nil
        @transport = nil
        
        # Process all binding and operation
        element.find_all {|e| e.class == REXML::Element }.each { |operation|
          case operation.name
            when "binding"
              # Get binding attributs
              operation.attributes.each { |name, value|
                case name
                  when 'style'
                    @style = value
                  when 'transport'
                    @transport = value
                  else
                    warn "Ignoring attribut `#{name}' for wsdlsoap:binding in binding `#{element.attributes['name']}'"
                end
              }
            when "operation"
              # Store operations
              @operations[operation.attributes['name']] = Hash.new()
              
              # Get operation attributs
              operation.attributes.each { |name, value|
                case name
                  when 'name'
                    @operations[operation.attributes['name']][:name] = value
                  else
                    warn "Ignoring attribut `#{name}' for operation `#{operation.attributes['name']}' in binding `#{element.attributes['name']}'"
                end
              }
              
              # Store operation input, output, fault and operation
              operation.find_all {|e| e.class == REXML::Element }.each { |action|
                case action.name
                  when "operation"
                    # Get operation attributs
                    action.attributes.each { |name, value|
                      case name
                        when 'soapAction'
                          @operations[operation.attributes['name']][:soapAction] = value
                        when 'style'
                          @operations[operation.attributes['name']][:style] = value
                        else
                          warn "Ignoring attribut `#{name}' for wsdlsoap:operation in operation `#{operation.attributes['name']}' in binding `#{element.attributes['name']}'"
                      end
                    }
                  when "input"
                    @operations[operation.attributes['name']][:input] = Hash.new
                    
                    # Store input attributs
                    action.attributes.each { |name, value|
                      case name
                        when 'name'
                          @operations[operation.attributes['name']][:input][:name] = value
                        else
                          warn "Ignoring attribut `#{name}' in #{action.name} `#{action.attributes['name']}' in operation `#{operation.attributes['name']}' for binding `#{element.attributes['name']}'"
                      end
                    }
                    
                    # Store body 
                    action.find_all {|e| e.class == REXML::Element }.each { |body|
                      case body.name
                        when "body"
                          @operations[operation.attributes['name']][:input][:body] = Hash.new
                          
                          # Store body attributes
                          body.attributes.each { |name, value|
                            @operations[operation.attributes['name']][:input][:body][name.to_sym] = value
                          }
                        else
                          warn "Ignoring element `#{body.name}' in #{action.name} `#{action.attributes['name']}' in operation `#{operation.attributes['name']}' for binding `#{element.attributes['name']}'"
                      end
                    }
                  when "output"
                    @operations[operation.attributes['name']][:output] = Hash.new
                    
                    # Store input attributs
                    action.attributes.each { |name, value|
                      case name
                        when 'name'
                          @operations[operation.attributes['name']][:output][:name] = value
                        else
                          warn "Ignoring attribut `#{name}' in #{action.name} `#{action.attributes['name']}' in operation `#{operation.attributes['name']}' for binding `#{element.attributes['name']}'"
                      end
                    }
                    
                    # Store body 
                    action.find_all {|e| e.class == REXML::Element }.each { |body|
                      case body.name
                        when "body"
                          @operations[operation.attributes['name']][:output][:body] = Hash.new
                          
                          # Store body attributes
                          body.attributes.each { |name, value|
                            @operations[operation.attributes['name']][:output][:body][name.to_sym] = value
                          }
                        else
                          warn "Ignoring element `#{body.name}' in #{action.name} `#{action.attributes['name']}' in operation `#{operation.attributes['name']}' for binding `#{element.attributes['name']}'"
                      end
                    }
                  when "fault"
                    @operations[operation.attributes['name']][:fault] = Hash.new
                    
                    # Store input attributs
                    action.attributes.each { |name, value|
                      case name
                        when 'name'
                          @operations[operation.attributes['name']][:fault][:name] = value
                        else
                          warn "Ignoring attribut `#{name}' in #{action.name} `#{action.attributes['name']}' in operation `#{operation.attributes['name']}' for binding `#{element.attributes['name']}'"
                      end
                    }
                    
                    # Store body 
                    action.find_all {|e| e.class == REXML::Element }.each { |body|
                      case body.name
                        when "body"
                          @operations[operation.attributes['name']][:fault][:body] = Hash.new
                          
                          # Store body attributes
                          body.attributes.each { |name, value|
                            @operations[operation.attributes['name']][:fault][:body][name.to_sym] = value
                          }
                        else
                          warn "Ignoring element `#{body.name}' in #{action.name} `#{action.attributes['name']}' in operation `#{operation.attributes['name']}' for binding `#{element.attributes['name']}'"
                      end
                    }                    
                  else
                    warn "Ignoring element `#{action.name}' in operation `#{operation.attributes['name']}' for binding `#{element.attributes['name']}'"
                end
              }
            else
              warn "Ignoring element `#{operation.name}' in binding `#{element.attributes['name']}'"
          end
        }
      end
    end
  end
end