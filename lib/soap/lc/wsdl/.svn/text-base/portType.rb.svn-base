module SOAP
  class WSDL
    class PortTypes < Hash
    end
    
    class PortType
      attr_reader :operations
      attr_reader :name
      
      def initialize( element )
        @operations = Hash.new
        @name = element.attributes['name']
        
        # Process all operations
        element.find_all {|e| e.class == REXML::Element }.each { |operation| 
          case operation.name
            when "operation"
              @operations[operation.attributes['name']] = Hash.new
              
              # Store operation attributs
              operation.attributes.each { |name, value|
                case name
                  when 'name'
                    @operations[operation.attributes['name']][:name] = value
                  else
                    warn "Ignoring attribut `#{name}' in operation `#{operation.attributes['name']}' for portType `#{element.attributes['name']}'"
                end
              }
              
              # Store operation input, output and/or fault
              operation.find_all {|e| e.class == REXML::Element }.each { |action|
                case action.name
                  when "input"
                    @operations[operation.attributes['name']][:input] = Hash.new
                    
                    # Store input attributs
                    action.attributes.each { |name, value|
                      case name
                        when 'name'
                          @operations[operation.attributes['name']][:input][:name] = value
                        when 'message'
                          @operations[operation.attributes['name']][:input][:message] = value
                        else
                          warn "Ignoring attribut `#{name}' in #{action.name} `#{action.attributes['name']}' in operation `#{operation.attributes['name']}' for portType `#{element.attributes['name']}'"
                      end
                    }
                  when "output"
                    @operations[operation.attributes['name']][:output] = Hash.new
                    
                    # Store output attributs
                    action.attributes.each { |name, value|
                      case name
                        when 'name'
                          @operations[operation.attributes['name']][:output][:name] = value
                        when 'message'
                          @operations[operation.attributes['name']][:output][:message] = value
                        else
                          warn "Ignoring attribut `#{name}' in #{action.name} `#{action.attributes['name']}' in operation `#{operation.attributes['name']}' for portType `#{element.attributes['name']}'"
                      end
                    }
                  when "fault"
                    @operations[operation.attributes['name']][:fault] = Hash.new
                    
                    # Store output attributs
                    action.attributes.each { |name, value|
                      case name
                        when 'name'
                          @operations[operation.attributes['name']][:fault][:name] = value
                        when 'message'
                          @operations[operation.attributes['name']][:fault][:message] = value
                        else
                          warn "Ignoring attribut `#{name}' in #{action.name} `#{action.attributes['name']}' in operation `#{operation.attributes['name']}' for portType `#{element.attributes['name']}'"
                      end
                    }
                  else
                    warn "Ignoring element `#{action.name}' in operation `#{operation.attributes['name']}' for portType `#{element.attributes['name']}'"
                end
              }
            else
              warn "Ignoring element `#{operation.name}' in portType `#{element.attributes['name']}'"
          end
        }
      end
    end
  end
end