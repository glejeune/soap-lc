require 'soap/lc/core_ext'

require 'soap/lc/xsd'
require 'soap/lc/response'
require 'soap/lc/version'
require 'soap/lc/error'

module SOAP
  class Request
    attr_reader :request

    def initialize( wsdl, binding ) #:nodoc:
      @wsdl = wsdl
      @binding = binding
      @request = nil
    end

    # Call a method for the current Request and get a SOAP::Response
    #
    # Example:
    #   wsdl = SOAP::LC.new( ).wsdl( "http://..." )
    #   request = wsdl.request( )
    #   response = request.myMethod( :param1 => "hello" )
    #     # => #<SOAP::Response:0xNNNNNN>
    def method_missing( id, *args ) 
      call( id.id2name, args[0] )
    end

    # Create a new SOAP::Request with the given envelope, uri and headers
    #
    # Example:
    #   e = '<SOAP-ENV:Envelope 
    #                    xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
    #                    xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
    #                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    #                    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    #                    SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
    #          <SOAP-ENV:Header/>
    #            <SOAP-ENV:Body>
    #              <HelloWorld xmlns="urn:MyWebService">
    #                <from>Greg</from>
    #              </HelloWorld>
    #            </SOAP-ENV:Body>
    #          </SOAP-ENV:Envelope>'
    #   r = SOAP::Request.request( e, "http://localhost:3000/hello/wsdl", "SOAPAction" => "my.soap.action" )
    def self.request( envelope, uri, headers = {} )
      req = new( nil, nil )
      req.r( envelope, uri, headers )
      return req
    end
    def r( envelope, uri, headers ) #:nodoc:
      @request = {
        :headers  => make_header( envelope, headers ),
        :envelope => envelope,
        :uri      => uri,
        :wsdl     => nil,
        :response => nil,
        :binding  => @binding,
        :method   => nil
      }
    end

    # Return available SOAP actions
    def operations
      @wsdl.bindings.getOperations( @binding )
    end
    
    # Call a method for the current Request
    #
    # Example:
    #   wsdl = SOAP::LC.new( ).wsdl( "http://..." )
    #   request = wsdl.request( )
    #   response = request.call( "myMethod", :param1 => "hello" )
    #     # => #<SOAP::Response:0xNNNNNN>
    def call( methodName, args )
      args = (args || {}) #.keys_to_sym!

      # Get Binding
      binding = @wsdl.bindings.getBindingForOperationName( @binding, methodName )
      if binding.size == 0
        raise SOAP::LCNoMethodError, "Undefined method `#{methodName}'"
      elsif binding.size > 1
        raise SOAP::LCError, "Ambigous method name `#{methodName}', please, specify a binding name"
      else
        binding = binding[0]
        @binding = binding.name
      end

      # Get Binding Operation
      binding_operation = binding.operations[methodName]

      # Get PortType
      portType = @wsdl.portTypes[binding.type.nns]
      portType_operation = portType.operations[methodName]

      # Get message for input operation
      input_message = @wsdl.messages[portType_operation[:input][:message].nns]

      # Create method
      soap_method = "<#{methodName} xmlns=\"#{@wsdl.targetNamespace}\">\n"
      input_message.parts.each do |_, attrs|
        case attrs[:mode]
          when :type
            if SOAP::XSD::ANY_SIMPLE_TYPE.include?( attrs[attrs[:mode]].nns )
              # Part refer to a builtin SimpleType
              soap_method << SOAP::XSD.displayBuiltinType( attrs[:name], args, 1, 1 )
            else
              # Part refer to an XSD simpleType or complexType defined in types
              element = @wsdl.types[attrs[attrs[:mode]].nns][:value]
              case element[:type]
                when :simpleType
                  soap_method << "<#{attrs[:name]}>\n#{element.display( @wsdl.types, args )}\n</#{attrs[:name]}>\n" # MAYBE ########## 
                when :complexType
                  soap_method << "<#{attrs[:name]}>\n#{element.display( @wsdl.types, args )}\n</#{attrs[:name]}>\n" # MAYBE ########## 
                else
                  raise SOAP::LCWSDLError, "Malformated part #{attrs[:name]}"
              end
            end
          when :element
            # Part refer to an XSD element
            element = @wsdl.types[attrs[attrs[:mode]].nns][:value]
            case element[:type]
              when :simpleType
                soap_method << element[element[:type]].display( @wsdl.types, args )
              when :complexType
                soap_method << element[element[:type]].display( @wsdl.types, args )
              else
                raise SOAL::LCWSDLError, "Malformated element `#{attrs[attrs[:mode]]}'"
            end
        
            ## TODO ---------- USE element[:key]
          else 
            raise SOAP::LCWSDLError, "Malformated part #{attrs[:name]}"
        end
      end
      soap_method += "</#{methodName}>\n"

      # Create SOAP Envelope
      envelope = soap_envelop do 
        soap_header + soap_body( soap_method )
      end

      # Create headers
      headers = Hash.new
      # Add SOAPAction to headers (if exist)
      action = begin
        binding_operation[:soapAction]
      rescue
        nil
      end
      headers['SOAPAction'] = action unless action.nil? or action.length == 0

      # Search URI
      service_port = @wsdl.services.getServicePortForBindingName( binding.name )
      address = service_port[:address]

      # Complete request
      @request = {
        :headers  => make_header( envelope, headers ),
        :envelope => envelope,
        :uri      => address,
        :wsdl     => @wsdl,
        :response => @wsdl.messages[portType_operation[:output][:message].nns].name,
        :binding  => @binding,
        :method   => methodName
      }
      
      return self
    end

    # Get the SOAP Body for the request
    def soap_body( soap_method )
      "<SOAP-ENV:Body>\n" + soap_method + "</SOAP-ENV:Body>\n"
    end

    # Send request to the server and get a response (SOAP::Response)
    def response( )
      return( SOAP::Response.new( @request ) )
    end
    alias_method :result, :response

    # Get the SOAP Envelope for the request
    def envelope( )
      @request[:envelope] || nil
    end

    # Get request headers
    def headers( )
      @request[:headers] || nil
    end
    
    # Get request URI
    def uri()
      @request[:uri] || nil
    end

    private
    def make_header( e, h = {} ) #:nodoc:
      {
        'User-Agent' => "SOAP::LC (#{SOAP::LC::VERSION}); Ruby (#{RUBY_VERSION})",
        'Content-Type' => 'text/xml', #'application/soap+xml; charset=utf-8',
        'Content-Length' => "#{e.length}"
      }.merge( h )
    end

    def soap_envelop( &b ) #:nodoc:
      "<SOAP-ENV:Envelope 
          xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"
          xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\"
          xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" 
          xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"
          SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">\n" +
        yield() +
      '</SOAP-ENV:Envelope>'
    end

    def soap_header()
      "<SOAP-ENV:Header/>\n"
    end    
  end
end
