module SOAP
  class XSD
    class Restriction < Hash
      def initialize( content )
        content.attributes.each { |name, value| 
          self[name.to_sym] = value
        }
        content.find_all{ |e| e.class == REXML::Element }.each { |restrictions|
          case restrictions.name
            when "annotation"
              ###############################################################################
              warn "xsd:annotation in xsd:restriction is not yet supported!"
              ###############################################################################
            when "fractionDigits"
              ###############################################################################
              warn "xsd:fractionDigits in xsd:restriction is not yet supported!"
              ###############################################################################
            when "enumeration"
              self[:enumeration] = SOAP::XSD::Enumeration.new unless self.has_key?( :enumeration )
              self[:enumeration] << restrictions.attributes['value']
            when "length"
              ###############################################################################
              warn "xsd:length in xsd:restriction is not yet supported!"
              ###############################################################################
            when "maxExclusive"
              ###############################################################################
              warn "xsd:maxExclusive in xsd:restriction is not yet supported!"
              ###############################################################################
            when "maxInclusive"
              ###############################################################################
              warn "xsd:maxInclusive in xsd:restriction is not yet supported!"
              ###############################################################################
            when "maxLength"
              ###############################################################################
              warn "xsd:maxLength in xsd:restriction is not yet supported!"
              ###############################################################################
            when "minExclusive"
              ###############################################################################
              warn "xsd:minExclusive in xsd:restriction is not yet supported!"
              ###############################################################################
            when "minInclusive"
              ###############################################################################
              warn "xsd:minInclusive in xsd:restriction is not yet supported!"
              ###############################################################################
            when "minLength"
              ###############################################################################
              warn "xsd:minLength in xsd:restriction is not yet supported!"
              ###############################################################################
            when "pattern"
              ###############################################################################
              warn "xsd:pattern in xsd:restriction is not yet supported!"
              ###############################################################################
            when "simpleType"
              ###############################################################################
              warn "xsd:simpleType in xsd:restriction is not yet supported!"
              ###############################################################################
            when "totalDigits"
              ###############################################################################
              warn "xsd:totalDigits in xsd:restriction is not yet supported!"
              ###############################################################################
            when "whiteSpace"
              ###############################################################################
              warn "xsd:whiteSpace in xsd:restriction is not yet supported!"
              ###############################################################################
            else
              warn "Ignoring `#{restrictions.name}' in xsd:restriction for xsd:simpleType `#{type.attributes['name']}'"
          end
        }
      end
    
      def responseToHash( xml, types )
        SOAP::XSD::Convert.to_ruby( self[:base].to_s, xml )
      end
    end
  end
end