require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'

GEM = "micronaut"
GEM_VERSION = "0.1.3.2"
AUTHOR = "Chad Humphries"
EMAIL = "chad@spicycode.com"
HOMEPAGE = "http://spicycode.com"
SUMMARY = "An excellent replacement for the wheel..."

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", "RSPEC-LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.bindir = 'bin'
  s.default_executable = 'micronaut'
  s.executables = ["micronaut"]
  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE README RSPEC-LICENSE Rakefile) + Dir.glob("{lib,examples}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end

desc "create a gemspec file"
task :make_gemspec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

namespace :micronaut do
  
  desc 'Run all examples'
  task :examples do
    examples = Dir["examples/**/*_example.rb"].map { |g| Dir.glob(g) }.flatten
    ruby examples.join(" ")
  end
  
  desc "List files that don't have examples"
  task :untested do
    code = Dir["lib/**/*.rb"].map { |g| Dir.glob(g) }.flatten
    examples = Dir["examples/**/*_example.rb"].map { |g| Dir.glob(g) }.flatten
    examples.map! { |f| f =~ /examples\/(.*)_example/; "#{$1}.rb" }
    missing_examples = (code - examples)
    puts
    puts "The following files seem to be missing their examples:"
    missing_examples.each do |missing|
      puts "  #{missing}"
    end
  end
  
  desc "Run all examples using rcov"
  task :coverage do
    examples = Dir["examples/**/*_example.rb"].map { |g| Dir.glob(g) }.flatten
    system "rcov --exclude \"examples/*,gems/*,db/*,/Library/Ruby/*,config/*\" --text-report --sort coverage --no-validator-links #{examples.join(' ')}"
  end
  
  desc "Delete coverage artifacts" 
  task :clean_coverage do
    rm_rf Dir["coverage/**/*"]
  end
  
end

task :default => 'micronaut:coverage'
task :clobber_package => 'micronaut:clean_coverage'

