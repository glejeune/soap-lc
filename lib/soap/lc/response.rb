require 'rexml/document'
require 'soap/lc/error'

module SOAP
  class Response
    # XML response
    attr_reader :to_xml
    # Hash response
    attr_reader :to_h
    
    def initialize( request ) #:nodoc:
      @request = request
      url = URI.parse( request[:uri] )
      @soap_response = Net::HTTP.new( url.host, url.port ).start { |http| 
        http.post( url.request_uri, @request[:envelope], @request[:headers] ) 
      }
      
      @to_xml = @soap_response.body
      @to_h = {}
      
      if @request[:wsdl].nil? or @request[:response].nil?
        require 'rubygems'
        require 'active_support'
        
        @to_h = Hash.from_xml( @soap_response.body )
      else
        processResponse() 
      end
    end
    
    def method_missing( id, *args )
      get( id.id2name )
    end
    
    def [](name)
      @to_h[name]
    end
    def get( name )
      @to_h[name]
    end
    
    # Return SOAP error
    def error
      @soap_response.error!
    end
    
    private
    def processResponse
      xml_result = REXML::Document.new( @to_xml )
      # raise SOAP::LCElementError, "Invalide SOAP response!" if xml_result.root.children[0].children[0].name != "#{@request[:method]}Response"
            
      xml_response = xml_result.root.children[0].children[0].children
      @request[:wsdl].messages[@request[:response]].parts.each do |_, attrs|
        case attrs[:mode]
          when :element
            @to_h = @request[:wsdl].types[attrs[:element].nns][:value].responseToHash( xml_response, @request[:wsdl].types )
          when :type
            if SOAP::XSD::ANY_SIMPLE_TYPE.include?( attrs[:type].nns )
              # **************************** TODO ************************************
            else
              # **************************** TODO ************************************
            end
          else
        end
      end      
    end
    
  end
end