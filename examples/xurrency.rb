$:.unshift( "../lib" )
require 'soap/lc'
require 'pp'

xurrency = SOAP::LC["http://xurrency.com/api.wsdl"]
pp xurrency.operations

puts "-------"
pp xurrency.getName( :code => 'eur' ).result.to_h
puts "-------"
pp xurrency.getValue( :amount => 100, :base => "eur", :target => "usd" ).result.to_h
puts "-------"
pp xurrency.getURL( :code => 'eur' ).result.to_h
puts "-------"
pp xurrency.getZone( :code => 'eur' ).result.to_h
puts "-------"
pp xurrency.isCurrency( :code => 'eur' ).result.to_h
