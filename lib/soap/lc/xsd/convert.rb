module SOAP
  class XSD
    class Convert
      
      def self.to_ruby( t, v )
        new().c( t.gsub( /.*:/, "xsd_" ), v )
      end
      
      def c( t, v )
        self.method( t ).call( v )
      end
      
      def xsd_int( x )
        x.to_i
      end
      alias_method :xsd_long, :xsd_int
      alias_method :xsd_integer, :xsd_int
      
      def xsd_float( x )
        x.to_f
      end
      alias_method :xsd_double, :xsd_float
      alias_method :xsd_decimal, :xsd_float
      
      def xsd_string( x )
        x
      end
      alias_method :xsd_normalizedString, :xsd_string
      
      def xsd_boolean( x )
        (x == "true")
      end
      
      def xsd_duration( x )
        x
      end 
      def xsd_dateTime( x )
        x
      end
      def xsd_time( x )
        x
      end 
      def xsd_date( x )
        x
      end
      def xsd_gYearMonth( x )
        x
      end
      def xsd_gYear( x )
        x
      end
      def xsd_gMonthDay( x )
        x
      end
      def xsd_gDay( x )
        x
      end
      def xsd_gMonth( x )
        x
      end
      def xsd_base64Binary( x )
        x
      end
      def xsd_hexBinary( x )
        x
      end
      def xsd_anyURI( x )
        x
      end
      def xsd_QName( x )
        x
      end
      def xsd_NOTATION( x )
        x
      end
      def xsd_token( x )
        x
      end
      def xsd_language( x )
        x
      end
      def xsd_Name( x )
        x
      end
      def xsd_NMTOKEN( x )
        x
      end
      def xsd_NCName( x )
        x
      end
      def xsd_NMTOKENS( x )
        x
      end
      def xsd_ID( x )
        x
      end
      def xsd_IDREF( x )
        x
      end
      def xsd_ENTITY( x )
        x
      end
      def xsd_IDREFS( x )
        x
      end
      def xsd_ENTITIES( x )
        x
      end
      def xsd_nonPositiveInteger( x )
        x
      end
      def xsd_nonNegativeInteger( x )
        x
      end
      def xsd_negativeInteger( x )
        x
      end
      def xsd_unsignedLong( x )
        x
      end
      def xsd_positiveInteger( x )
        x
      end
      def xsd_short( x )
        x
      end
      def xsd_unsignedInt( x )
        x
      end
      def xsd_byte( x )
        x
      end
      def xsd_unsignedShort( x )
        x
      end
      def xsd_unsignedByte( x )
        x
      end
    end
  end
end
    