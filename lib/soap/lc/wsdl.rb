require 'soap/lc/wsdl/parser'
require 'soap/lc/request'

module SOAP 
  class WSDL
    attr_reader :parse
    
    def initialize( uri, binding ) #:nodoc:
      @parse = SOAP::WSDL::Parser.new( uri )
      @binding = binding
    end
    
    # Call a method for the current WSDL and get the corresponding SOAP::Request
    #
    # Example:
    #   wsdl = SOAP::LC.new( ).wsdl( "http://..." )
    #   request = wsdl.myMethod( :param1 => "hello" )
    #     # => #<SOAP::Request:0xNNNNNN>
    def method_missing( id, *args ) 
      return request( @binding ).call( id.id2name, args[0] )
    end
    
    # Return available SOAP operations
    def operations
      return request( @binding ).operations
    end
    
    # Call a method for the current WSDL and get the corresponding SOAP::Request
    #
    # Example:
    #   wsdl = SOAP::LC.new( ).wsdl( "http://..." )
    #   request = wsdl.call( "myMethod", { :param1 => "hello" } )
    #     # => #<SOAP::Request:0xNNNNNN>
    def call( name, args = {} )
      return request( @binding ).call( name, args )
    end
    
    # Get a SOAP::Request object for the current WSDL
    #
    # Example:
    #   wsdl = SOAP::LC.new( ).wsdl( "http://..." )
    #   request = wsdl.request( )
    #     # => #<SOAP::Request:0xNNNNNN>
    def request( binding = nil )
      return SOAP::Request.new( @parse, binding )
    end
  end      
end