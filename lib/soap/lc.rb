require 'soap/lc/wsdl'

module SOAP
  class LC
    # Create a new SOAP Lite Client
    # 
    #   s = WSDL::LC.new( )
    #     # => #<SOAP::LC:0xNNNNNN>
    def initialize( ) #:nodoc:
    end
    
    # Set the WSDL URL and return a SOAP::WSDL object
    # 
    # Parameters :
    #   +uri+ : path to the WSDL
    #   +binding+ : binding name (optional)
    #
    # Example :
    #   s = WSDL::LC.new().wsdl( "http://my.wsdl.com", "HelloService" )
    #     # => #<SOAP::WSDL:0xNNNNNN>
    def wsdl( uri, binding = nil )
      SOAP::WSDL.new( uri, binding )
    end
    
    # Set the WSDL URL and return a SOAP::WSDL object
    # 
    # Parameters :
    #   +uri+ : path to the WSDL
    #   +binding+ : binding name (optional)
    #
    # Example :
    #   s = WSDL::LC.wsdl( "http://my.wsdl.com", "HelloService" )
    #     # => #<SOAP::WSDL:0xNNNNNN>
    def self.wsdl( uri, binding = nil )
      SOAP::WSDL.new( uri, binding )
    end
    
    # Create a new SOAP Lite client and set the WSDL URL
    # Return a SOAP::WSDL object.
    #
    # Use this if binding is non ambigous
    #
    #   s = SOAP::LC["http://my.wsdl.com"]
    def self.[]( uri )
      SOAP::LC.wsdl( uri, nil )
    end
  end
end