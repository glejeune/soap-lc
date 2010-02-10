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
      end 
      def xsd_dateTime( x )
      end
      def xsd_time( x )
      end 
      def xsd_date( x )
      end
      def xsd_gYearMonth( x )
      end
      def xsd_gYear( x )
      end
      def xsd_gMonthDay( x )
      end
      def xsd_gDay( x )
      end
      def xsd_gMonth( x )
      end
      def xsd_base64Binary( x )
      end
      def xsd_hexBinary( x )
      end
      def xsd_anyURI( x )
      end
      def xsd_QName( x )
      end
      def xsd_NOTATION( x )
      end
      def xsd_token( x )
      end
      def xsd_language( x )
      end
      def xsd_Name( x )
      end
      def xsd_NMTOKEN( x )
      end
      def xsd_NCName( x )
      end
      def xsd_NMTOKENS( x )
      end
      def xsd_ID( x )
      end
      def xsd_IDREF( x )
      end
      def xsd_ENTITY( x )
      end
      def xsd_IDREFS( x )
      end
      def xsd_ENTITIES( x )
      end
      def xsd_nonPositiveInteger( x )
      end
      def xsd_nonNegativeInteger( x )
      end
      def xsd_negativeInteger( x )
      end
      def xsd_unsignedLong( x )
      end
      def xsd_positiveInteger( x )
      end
      def xsd_short( x )
      end
      def xsd_unsignedInt( x )
      end
      def xsd_byte( x )
      end
      def xsd_unsignedShort( x )
      end
      def xsd_unsignedByte( x )
      end
    end
  end
end
    