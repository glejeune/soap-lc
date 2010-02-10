module SOAP
  class XSD
    class ComplexType < Hash
      def initialize( type )
        type.attributes.each { |name, value|
          self[name.to_sym] = value
        }

        type.find_all{ |e| e.class == REXML::Element }.each { |content|
          case content.name
            when "simpleContent"
              raise SOAP::LCElementError, "Malformated complexType `#{type.attributes['name']}'" unless self[:type].nil?
              self[:type] = :simpleContent
              ###############################################################################
              warn "xsd:simpleContent in xsd:complexType (global definition) is not yet supported!"
              ###############################################################################
            when "complexContent"
              raise SOAP::LCElementError, "Malformated complexType `#{type.attributes['name']}'" unless self[:type].nil?
              self[:type] = :complexContent
              ###############################################################################
              warn "xsd:complexContent in xsd:complexType (global definition) is not yet supported!"
              ###############################################################################
            when "group"
              raise SOAP::LCElementError, "Malformated complexType `#{type.attributes['name']}'" unless self[:type].nil?
              self[:type] = :group
              ###############################################################################
              warn "xsd:group in xsd:complexType (global definition) is not yet supported!"
              ###############################################################################
            when "all"
              raise SOAP::LCElementError, "Malformated complexType `#{type.attributes['name']}'" unless self[:type].nil?
              self[:type] = :all
              ###############################################################################
              warn "xsd:all in xsd:complexType (global definition) is not yet supported!"
              ###############################################################################
            when "choise"
              raise SOAP::LCElementError, "Malformated complexType `#{type.attributes['name']}'" unless self[:type].nil?
              self[:type] = :choise
              ###############################################################################
              warn "xsd:choise in xsd:complexType (global definition) is not yet supported!"
              ###############################################################################
            when "sequence"
              raise SOAP::LCElementError, "Malformated complexType `#{type.attributes['name']}'" unless self[:type].nil?
              self[:type] = :sequence
              self[:sequence] = SOAP::XSD::Sequence.new( content )
            when "attribute"
              raise SOAP::LCElementError, "Malformated complexType `#{type.attributes['name']}'" if (not(self[:attributes_type].nil?) and self[:attributes_type] != :attribute) or [:simpleContent, :complexContent].include?(self[:type])
              self[:attributes_type] = :attribute
              ###############################################################################
              warn "xsd:attribute in xsd:complexType (global definition) is not yet supported!"
              ###############################################################################
            when "attributeGroup"
              raise SOAP::LCElementError, "Malformated complexType `#{type.attributes['name']}'" if (not(self[:attributes_type].nil?) and self[:attributes_type] != :attributeGroup) or [:simpleContent, :complexContent].include?(self[:type])
              self[:attributes_type] = :attributeGroup
              ###############################################################################
              warn "xsd:attributeGroup in xsd:complexType (global definition) is not yet supported!"
              ###############################################################################
            when "anyAttribute"
              raise SOAP::LCElementError, "Malformated complexType `#{type.attributes['name']}'" if not(self[:any_attributes].nil?) or [:simpleContent, :complexContent].include?(self[:type])
              self[:any_attributes] = :anyAttribute
              ###############################################################################
              warn "xsd:anyAttribute in xsd:complexType (global definition) is not yet supported!"
              ###############################################################################
            when "annotation"
              ###############################################################################
              warn "xsd:annotation in xsd:complexType (global definition) (global definition) is not yet supported!"
              ###############################################################################            
            else
              raise SOAP::LCElementError, "Invalid element `#{content.name}' in xsd:complexType `#{type.attributes['name']}'"
          end
        }
      end
      
      def display( types, args )
        r = ""
        
        case self[:type]
          when :simpleContent
            ###############################################################################
            warn "xsd:simpleContent in xsd:complexType (global definition) is not yet supported!"
            ###############################################################################
          when :complexContent
            ###############################################################################
            warn "xsd:complexContent in xsd:complexType (global definition) is not yet supported!"
            ###############################################################################
          when :group
            ###############################################################################
            warn "xsd:group in xsd:complexType (global definition) is not yet supported!"
            ###############################################################################
          when :all
            ###############################################################################
            warn "xsd:all in xsd:complexType (global definition) is not yet supported!"
            ###############################################################################
          when :choise
            ###############################################################################
            warn "xsd:choise in xsd:complexType (global definition) is not yet supported!"
            ###############################################################################
          when :sequence
            r << self[:sequence].display( types, args )
          #else
          #  raise SOAP::LCWSDLError, "Malformated complexType `#{self[:name]}'"
        end
        
        return r
      end
    
      def responseToHash( xml, types )
        r = {}
        case self[:type]
          when :simpleContent
            ###############################################################################
            warn "xsd:simpleContent in xsd:complexType (global definition) is not yet supported!"
            ###############################################################################
          when :complexContent
            ###############################################################################
            warn "xsd:complexContent in xsd:complexType (global definition) is not yet supported!"
            ###############################################################################
          when :group
            ###############################################################################
            warn "xsd:group in xsd:complexType (global definition) is not yet supported!"
            ###############################################################################
          when :all
            ###############################################################################
            warn "xsd:all in xsd:complexType (global definition) is not yet supported!"
            ###############################################################################
          when :choise
            ###############################################################################
            warn "xsd:choise in xsd:complexType (global definition) is not yet supported!"
            ###############################################################################
          when :sequence
            r = self[:sequence].responseToHash( xml, types )
        end
        return r
      end
    end
  end
end