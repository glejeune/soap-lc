module SOAP
  class XSD
    class Sequence < Hash
      def initialize( type )
        type.attributes.each { |name, value|
          self[name.to_sym] = value
        }
        
        type.find_all{ |e| e.class == REXML::Element }.each { |content|
          case content.name
            when "annotation"
              ###############################################################################
              warn "xsd:annotation in xsd:sequence is not yet supported!"
              ###############################################################################
            when "element"
              raise SOAP::LCElementError, "Malformated sequence" unless self[:type].nil? or self[:type] = :element
              if self[:type].nil?
                self[:type] = :element
                self[:element] = Array.new
              end
              self[:element] << SOAP::XSD::Element.new( content )
            when "choice"
              raise SOAP::LCElementError, "Malformated sequence" unless self[:type].nil? or self[:type] = :choice
              self[:type] = :choice
              ###############################################################################
              warn "xsd:choice in xsd:sequence is not yet supported!"
              ###############################################################################              
            when "group"
              raise SOAP::LCElementError, "Malformated sequence" unless self[:type].nil? or self[:type] = :group
              self[:type] = :group
              ###############################################################################
              warn "xsd:group in xsd:sequence is not yet supported!"
              ###############################################################################              
            when "sequence"
              raise SOAP::LCElementError, "Malformated sequence" unless self[:type].nil? or self[:type] = :sequence
              self[:type] = :sequence
              ###############################################################################
              warn "xsd:sequence in xsd:sequence is not yet supported!"
              ###############################################################################              
            when "any"
              raise SOAP::LCElementError, "Malformated sequence" unless self[:type].nil? or self[:type] = :any
              self[:type] = :any
              ###############################################################################
              warn "xsd:any in xsd:sequence is not yet supported!"
              ###############################################################################              
            else
              raise SOAP::LCElementError, "Invalid element `#{content.name}' in xsd:sequence"
          end
        }
      end
      
      def display( types, args )
        r = ""
        
        case self[:type]
          when :element
            self[:element].each { |element|
              r << element.display( types, args )
            }
          when :choice
            ###############################################################################
            warn "xsd:choice in xsd:sequence is not yet supported!"
            ###############################################################################              
          when :group
            ###############################################################################
            warn "xsd:group in xsd:sequence is not yet supported!"
            ###############################################################################              
          when :sequence
            ###############################################################################
            warn "xsd:sequence in xsd:sequence is not yet supported!"
            ###############################################################################              
          when :any
            ###############################################################################
            warn "xsd:any in xsd:sequence is not yet supported!"
            ###############################################################################              
          else
            raise SOAP::LCWSDLError, "Malformated sequence `#{self[:name]}'"
        end
      
        return r
      end
    
      def responseToHash( xml, types )
        r = {}
        
        case self[:type]
          when :element
            self[:element].each { |element|
              element.responseToHash( xml, types ).each { |k, v|
                r[k] = v
              }
            }
          when :choice
            ###############################################################################
            warn "xsd:choice in xsd:sequence is not yet supported!"
            ###############################################################################              
          when :group
            ###############################################################################
            warn "xsd:group in xsd:sequence is not yet supported!"
            ###############################################################################              
          when :sequence
            ###############################################################################
            warn "xsd:sequence in xsd:sequence is not yet supported!"
            ###############################################################################              
          when :any
            ###############################################################################
            warn "xsd:any in xsd:sequence is not yet supported!"
            ###############################################################################              
          else
            raise SOAP::LCWSDLError, "Malformated sequence `#{self[:name]}'"
        end
        
        return r
      end
    end
  end
end