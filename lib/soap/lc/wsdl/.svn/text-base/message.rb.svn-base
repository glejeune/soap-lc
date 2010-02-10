module SOAP
  class WSDL
    class Messages < Hash
    end
    
    class Message
      attr_reader :parts
      attr_reader :name
      
      def initialize( element )
        @parts = Hash.new
        @name = element.attributes['name']

        # Process all parts
        element.find_all {|e| e.class == REXML::Element }.each { |part| 
          case part.name
            when "part"
              @parts[part.attributes['name']] = Hash.new
              
              # Store part attributs
              part.attributes.each { |name, value|
                case name
                  when 'name'
                    @parts[part.attributes['name']][:name] = value
                  when 'element'
                    @parts[part.attributes['name']][:element] = value
                    @parts[part.attributes['name']][:mode] = :element
                  when 'type'
                    @parts[part.attributes['name']][:type] = value
                    @parts[part.attributes['name']][:mode] = :type
                  else
                    warn "Ignoring attribut `#{name}' in part `#{part.attributes['name']}' for message `#{element.attributes['name']}'"
                end
              }
            else
              warn "Ignoring element `#{part.name}' in message `#{element.attributes['name']}'"
          end
        }
      end
    end
  end
end