Gem::Specification.new do |s|
  s.name        = 'chemspider'
  s.version     = '0.0.1'
  s.date        = '2012-10-14'
  s.summary     = 'ChemSpider API'
  s.description = 'The ChemSpider API (REST interface) wrapped up with a Ruby bow'
  s.authors     = ['Mark Borkum']
  s.email       = 'm.i.borkum@soton.ac.uk'
  s.files       = ['lib/chemspider.rb', 'lib/chem_spider.rb'] + %w{in_ch_i mass_spec_a_p_i open_babel search spectra}.map { |f| 'lib/chem_spider/%s.rb' % f }
  s.homepage    = 'https://github.com/markborkum/chemspider'
  s.requirements = 'nokogiri'
end
