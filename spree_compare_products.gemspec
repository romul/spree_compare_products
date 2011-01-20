# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'spree_compare_products/version'

Gem::Specification.new do |s|
  s.name        = 'spree_compare_products'
  s.version     = SpreeCompareProducts::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = [ 'Jorge Calás', 'Maik Kempe' ]
  s.email       = [ 'calas@qvitta.net', 'dev@breaking-limits.com' ]
  s.homepage    = 'https://github.com/mkempe/spree_compare_products'
  s.summary     = %q{Provides product comparison with other products within the same taxon.}
  # s.description = %q{}
  
  s.rubyforge_project = 'spree_compare_products'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = [ 'lib' ]
  s.requirements  << 'none'
  
  s.required_ruby_version = '>= 1.8.7'
  
  s.add_dependency('spree_core', '>= 0.40.99')
end
