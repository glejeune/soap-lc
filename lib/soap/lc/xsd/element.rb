module SOAP
  class XSD
    class Element < Hash
      def initialize( type )
        type.attributes.each { |name, value|
          self[name.to_sym] = value
        }
        
        type.find_all{ |e| e.class == REXML::Element }.each { |content|
          case content.name
            when "simpleType"
              raise SOAP::LCElementError, "Malformated element `#{type.attributes['name']}'" unless self[:type].nil?
              self[:type] = :simpleType
              ###############################################################################
              warn "xsd:simpleType in xsd:element is not yet supported!"
              ###############################################################################
            when "complexType"
              raise SOAP::LCElementError, "Malformated element `#{type.attributes['name']}'" unless self[:type].nil?
              self[:type] = :complexType
              self[:complexType] = SOAP::XSD::ComplexType.new( content )
            when "unique"
              raise SOAP::LCElementError, "Malformated element `#{type.attributes['name']}'" unless self[:key].nil?
              self[:key] = :unique
              ###############################################################################
              warn "xsd:unique in xsd:element is not yet supported!"
              ###############################################################################
            when "key"
              raise SOAP::LCElementError, "Malformated element `#{type.attributes['name']}'" unless self[:key].nil?
              self[:key] = :key
              ###############################################################################
              warn "xsd:unique in xsd:element is not yet supported!"
              ###############################################################################
            when "keyref"
              raise SOAP::LCElementError, "Malformated element `#{type.attributes['name']}'" unless self[:key].nil?
              self[:key] = :keyref
              ###############################################################################
              warn "xsd:unique in xsd:element is not yet supported!"
              ###############################################################################
            when "annotation"
              ###############################################################################
              warn "xsd:annotation in xsd:complexType (global definition) (global definition) is not yet supported!"
              ###############################################################################            
            else
              raise SOAP::LCElementError, "Invalid element `#{content.name}' in xsd:element `#{type.attributes['name']}'"
          end
        }
      end
    
      def display( types, args )
        r = ""
        
        min, max = getOccures( args )
        if SOAP::XSD::ANY_SIMPLE_TYPE.include?( self[:type].nns )
          r << SOAP::XSD.displayBuiltinType( self[:name], args, min, max )
        else
          case types[self[:type].nns][:type]
            when :simpleType
              if args.keys.include?( self[:name].to_sym )
                args[self[:name].to_sym] = [args[self[:name].to_sym]] unless args[self[:name].to_sym].class == Array
                if args[self[:name].to_sym].size < min or args[self[:name].to_sym].size > max
                  raise SOAP::LCArgumentError, "Wrong number or values for parameter `#{name}'"
                end
                args[self[:name].to_sym].each { |v|
                  r << "<#{self[:name]}>"
                  r << "#{v}" ############ CHECK !!!
                  r << "</#{self[:name]}>\n"
                }
              elsif min > 0
                raise SOAP::LCArgumentError, "Missing parameter `#{name}'" if min > 0
              end
            when :complexType
              if args.keys.include?( self[:name].to_sym )
                if args.keys.include?( self[:name].to_sym )
                  args[self[:name].to_sym] = [args[self[:name].to_sym]] unless args[self[:name].to_sym].class == Array
                  if args[self[:name].to_sym].size < min or args[self[:name].to_sym].size > max
                    raise SOAP::LCArgumentError, "Wrong number or values for parameter `#{name}'"
                  end
                  args[self[:name].to_sym].each { |v|
                    r << "<#{self[:name]}>"
                    r << types[self[:type].nns][:value].display( types, v )
                    r << "</#{self[:name]}>\n"
                  }
                elsif min > 0
                  raise SOAP::LCArgumentError, "Missing parameter `#{name}'" if min > 0
                end
              else
                r << "<#{self[:name]}>\n"
                r << types[self[:type].nns][:value].display( types, args )
                r << "</#{self[:name]}>\n"
              end
            else
              raise SOAL::LCWSDLError, "Malformated element `#{self[:name]}'"
          end          
        end
        
        return r
      end
      
      def getOccures( args )
        element_min = self[:minOccurs].to_i || 1
        element_max = self[:maxOccurs] || "1"
        if element_max == "unbounded"
          if args.keys.include?(self[:name].to_sym)
            if args[self[:name].to_sym].class == Array
              element_max = args[self[:name].to_sym].size
            else
              element_max = 1
            end
          else
            element_max = 1
          end
        else
          element_max = element_max.to_i
        end

        return( [element_min, element_max] )
      end
      
      def responseToHash( xml, types )
        r = {}

        if SOAP::XSD::ANY_SIMPLE_TYPE.include?( self[:type].to_s.nns )
          xml.each { |e| 
            if e.name == self[:name]
              r[self[:name]] = SOAP::XSD::Convert.to_ruby( self[:type].to_s, e.text )
            end
          }
        else
          case self[:type]
            when :simpleType
              # **************************** TODO ************************************
            when :complexType
              # **************************** NEED TO BE VERIFIED ************************************
              r = self[:complexType].responseToHash( xml, types )
            else
              xml.each { |e| 
                if e.name == self[:name]
                  case types[self[:type].to_s.nns][:type]
                    when :simpleType
                      if r.keys.include?(self[:name])
                        unless r[self[:name]].class == Array
                          r[self[:name]] = [r[self[:name]]]
                        end
                        r[self[:name]] << types[self[:type].to_s.nns][:value].responseToHash( e.text, types )
                      else
                        r[self[:name]] = types[self[:type].to_s.nns][:value].responseToHash( e.text, types )
                      end
                    else
                      if r.keys.include?(self[:name])
                        unless r[self[:name]].class == Array
                          r[self[:name]] = [r[self[:name]]]
                        end
                        r[self[:name]] << types[self[:type].to_s.nns][:value].responseToHash( e, types )
                      else
                        r[self[:name]] = types[self[:type].to_s.nns][:value].responseToHash( e, types )
                      end
                  end
                end
              }
          end
        end
        
        return r
      end
    end
  end
end