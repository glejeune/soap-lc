require "test/unit"
$:.unshift( "../lib" )
require 'soap/lc'

class XsltTest < Test::Unit::TestCase
  def setup
    @wsdl = "sample.wsdl"
    @s = SOAP::LC.new( )
  end
  
  def test_instance
    assert_instance_of( SOAP::LC, @s )
  end
  
  def test_wsdl_load
    @w = @s.wsdl( @wsdl )
    assert_instance_of( SOAP::WSDL, @w )
  end
  
  def test_cant_open_file
    assert_raise SOAP::LCError do
      w = @s.wsdl( "this_file_does_not_exist.wsdl" )
    end
  end

  def test_cant_open_uri
    assert_raise SOAP::LCError do
      w = @s.wsdl( "http://localhost:9999/this_file_does_not_exist.wsdl" )
    end
  end

  def test_file_404
    assert_raise SOAP::LCError do
      w = @s.wsdl( "http://soap-lc.rubyforge.org/this_file_does_not_exist.wsdl" )
    end
  end
  
  def test_undefine_method
    assert_raise NoMethodError do
      @w.thisMethodDoesNotExist( )
    end
  end
end