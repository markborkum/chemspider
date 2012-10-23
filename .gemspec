#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.version            = File.read('VERSION').chomp
  s.date               = File.mtime('VERSION').strftime('%Y-%m-%d')
  
  s.name               = 'chemspider'
  s.homepage           = 'https://github.com/markborkum/chemspider'
  s.license            = 'Public Domain' if s.respond_to?(:license=)
  s.summary            = 'A Ruby library for working with the ChemSpider API.'
  s.description        = 'ChemSpider.rb: ChemSpider wrapped up with a Ruby bow.'
# s.rubyforge_project  = nil
  
  s.author             = 'Mark Borkum'
  s.email              = 'm.i.borkum@soton.ac.uk'
  
  s.platform           = Gem::Platform::RUBY
  s.files              = %w{AUTHORS README UNLICENSE VERSION} + Dir.glob('lib/**/*.rb')
  s.require_paths      = %w{lib}
  s.has_rdoc           = false
  
  s.required_ruby_version      = '>= 1.8.7'
  s.requirements               = []
  s.add_runtime_dependency     'nokogiri', '>= 1.5.0'
  s.add_development_dependency 'yard', '>= 0.7.2'
  s.post_install_message       = nil
end
