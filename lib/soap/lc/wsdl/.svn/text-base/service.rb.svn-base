module SOAP
  class WSDL
    class Services < Hash
      def getServicePortForBindingName( name )
        self.each do |binding_name, binding|
          binding.ports.each do |port_name, port|
            return port if port[:binding].nns == name
          end
        end
        return nil
      end
    end
    
    class Service
      attr_reader :ports
      attr_reader :name
      
      def initialize( element )
        @ports = Hash.new
        @name = element.attributes['name']
        
        # Process all ports
        element.find_all {|e| e.class == REXML::Element }.each { |port|
          case port.name
            when "port"
              @ports[port.attributes['name']] = Hash.new
              
              # Store port attributs             
              port.attributes.each { |name, value|
                case name
                  when 'name'
                    @ports[port.attributes['name']][:name] = value
                  when 'binding'
                    @ports[port.attributes['name']][:binding] = value
                  else
                    warn "Ignoring attribut `#{name}' in port `#{port.attributes['name']}' for service `#{element.attributes['name']}'"
                end
              }
              
              # Store port soap:address
              port.find_all {|e| e.class == REXML::Element }.each { |address|
                case address.name
                  when "address"
                    @ports[port.attributes['name']][:address] = address.attributes['location']
                  else
                    warn "Ignoring element `#{address.name}' in port `#{port.attributes['name']}' for service `#{element.attributes['name']}'"
                end
              }
            else
              warn "Ignoring element `#{port.name}' in service `#{element.attributes['name']}'"
          end
        }
      end
    end
  end
end