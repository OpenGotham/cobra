require 'rubygems'
require 'rake'
require 'rake/testtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "cobra"
    gem.summary = %Q{An extension of the cijoe project}
    gem.description = %Q{An extension of the cijoe project now more descriptive}
    gem.email = "mjording@opengotham.com"
    gem.homepage = "http://github.com/OpenGotham/cobra"
    gem.authors = ["matthew jording"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "yard", ">= 0"
    gem.add_dependency 'unicorn'
    gem.add_dependency "sinatra"
    gem.files = Dir.glob('lib/**/*.rb')
    gem.files = Dir.glob('lib/**/**/*')
    gem.executables        = %w(cobra)
    gem.default_executable = "cobra"
    gem.require_paths      = ["lib"]
  end
  Jeweler::GemcutterTasks.new

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
  # 
  #   
  # require 'spec/rake/spectask'
  # Spec::Rake::SpecTask.new(:spec) do |spec|
  #   spec.libs << 'lib' << 'spec'
  #   spec.spec_files = FileList['spec/**/*_spec.rb']
  # end
  # 
  # Spec::Rake::SpecTask.new(:rcov) do |spec|
  #   spec.libs << 'lib' << 'spec'
  #   spec.pattern = 'spec/**/*_spec.rb'
  #   spec.rcov = true
  # end
  # task :spec => :check_dependencies
  # 
  
begin
  require 'reek/adapters/rake_task'
  Reek::RakeTask.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort "Reek is not available. In order to run reek, you must: sudo gem install reek"
  end
end

begin
  require 'roodi'
  require 'roodi_task'
  RoodiTask.new do |t|
    t.verbose = false
  end
rescue LoadError
  task :roodi do
    abort "Roodi is not available. In order to run roodi, you must: sudo gem install roodi"
  end
end
# task :default => :spec



begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end



Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "someproject #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
