require 'open-uri'
require 'rexml/document'

require 'soap/lc/error'
require 'soap/lc/wsdl/message'
require 'soap/lc/wsdl/portType'
require 'soap/lc/wsdl/binding'
require 'soap/lc/wsdl/service'
require 'soap/lc/xsd'

module SOAP
  class WSDL
    class Parser
      attr_reader :types
      attr_reader :messages
      attr_reader :portTypes
      attr_reader :bindings
      attr_reader :services
      
      attr_reader :prefixes
      attr_reader :targetNamespace
      
      attr_reader :document
      
      def initialize( uri )
        @types = SOAP::XSD.new()
        @messages = SOAP::WSDL::Messages.new
        @portTypes = SOAP::WSDL::PortTypes.new
        @bindings = SOAP::WSDL::Bindings.new
        @services = SOAP::WSDL::Services.new
        
        @prefixes = Hash.new
        @targetNamespace = ""

        # Get WSDL 
        source = nil
        begin
          open( uri ) do |f|
            source = f.read
          end
        rescue Errno::ECONNREFUSED, Errno::ENOENT, OpenURI::HTTPError => e
          raise SOAP::LCError, "Can't open '#{uri}' : #{e.message}"
        end

        # Parse WSDL content
        @document = REXML::Document.new( source )
        
        processAttributes @document.root.attributes
        processContent @document.root.children
      end
      
      private
      def processAttributes( attributes )
        @targetNamespace = attributes["targetNamespace"]
        attributes.values.each{ |attribute|
          if attribute.prefix == "xmlns" then
            @prefixes[attribute.name] = attribute.value
          end
        }
        if(default_namespace = attributes["xmlns"]) then
          @prefixes["__default__"] = default_namespace
        end
      end
      
      def processContent( elements )
        elements.find_all {|e| e.class == REXML::Element }.each { |element| 
          case element.name
            when "types"
              processTypes( element )
            when "message"
              processMessage( element )
            when "portType" 
              processPortType( element )
            when "binding"
              processBinding( element )
            when "service"
              processService( element )
            else
              warn "Ignoring #{element}"
          end
        }
      end
      
      def processTypes( element )
        @types.add_schema( element )
      end
      
      def processMessage( element )
        name = element.attributes['name']
        @messages[name] = SOAP::WSDL::Message.new( element )
      end
      
      def processPortType( element )
        name = element.attributes['name']
        @portTypes[name] = SOAP::WSDL::PortType.new( element )
      end
      
      def processBinding( element )
        name = element.attributes['name']
        @bindings[name] = SOAP::WSDL::Binding.new( element )
      end
      
      def processService( element )
        name = element.attributes['name']
        @services[name] = SOAP::WSDL::Service.new( element )
      end
    end
  end
end