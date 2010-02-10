require 'rubygems'
require 'rake'
require 'lib/soap/lc/version'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "soap-lc"
    gem.summary = %Q{SOAP Lite Client provides support for developing clients interfaces from WSDL files.}
    gem.description = gem.summary
    gem.email = "gregoire.lejeune@free.fr"
    gem.homepage = "http://github.com/glejeune/soap-lc"
    gem.authors = ["Grégoire Lejeune"]
    gem.version = SOAP::LC::VERSION
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    
    gem.add_dependency('activesupport')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "soap-lc #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
