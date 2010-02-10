module SOAP
  class XSD
    class SimpleType < Hash
      def initialize( type )
        type.attributes.each { |name, value|
          self[name.to_sym] = value
        }
        
        type.find_all{ |e| e.class == REXML::Element }.each { |content|
          case content.name
            when "list"
              raise SOAP::LCElementError, "Malformated simpleType `#{type.attributes['name']}'" unless self[:type].nil?
              self[:type] = :list
              self[:list] = nil
              ###############################################################################
              warn "xsd:list in xsd:simpleType is not yet supported!"
              ###############################################################################
            when "union"
              raise SOAP::LCElementError, "Malformated simpleType `#{type.attributes['name']}'" unless self[:type].nil?
              self[:type] = :union
              self[:union] = nil
              ###############################################################################
              warn "xsd:union in xsd:simpleType is not yet supported!"
              ###############################################################################
            when "restriction"
              raise SOAP::LCElementError, "Malformated simpleType `#{type.attributes['name']}'" unless self[:type].nil?
              self[:type] = :restriction
              self[:restriction] = SOAP::XSD::Restriction.new( content )
            when "annotation"
              ###############################################################################
              warn "xsd:annotation in xsd:simpleType is not yet supported!"
              ###############################################################################            
            else
              raise SOAP::LCElementError, "Invalid element `#{content.name}' in xsd:simpleType `#{type.attributes['name']}'"
          end
        }
      end
      
      def display( types, args )
        r = ""

        case self[:type]
          when :restriction
            # TODO ########################################################################
            # TODO ########################################################################
            # TODO ########################################################################
            # TODO ########################################################################              
          when :list
            ###############################################################################
            warn "xsd:list in xsd:simpleType is not yet supported!"
            ###############################################################################
          when :union
            ###############################################################################
            warn "xsd:union in xsd:simpleType is not yet supported!"
            ###############################################################################
          else
            raise SOAP::LCWSDLError, "Malformated simpleType `#{self[:name]}'"
        end

        return r
      end
      
      def responseToHash( xml, types )
        r = nil
        case self[:type]
          when :restriction
            r = self[:restriction].responseToHash( xml, types )
          when :list
            ###############################################################################
            warn "xsd:list in xsd:simpleType is not yet supported!"
            ###############################################################################
          when :union
            ###############################################################################
            warn "xsd:union in xsd:simpleType is not yet supported!"
            ###############################################################################
          else
            raise SOAP::LCWSDLError, "Malformated simpleType `#{self[:name]}'"
        end
        return r
      end
    end
  end
end