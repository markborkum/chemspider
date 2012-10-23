#!/usr/bin/env ruby
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))
require 'rubygems'
begin
  require 'rakefile' # @see https://github.com/markborkum/chemspider
rescue LoadError => e
end

require 'chemspider'

desc "Build the chemspider-#{File.read('VERSION').chomp}.gem file"
task :build do
  sh "gem build .gemspec"
end
