# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_drop_shipping/version"

Gem::Specification.new do |s|
  s.name        = "spree_drop_shipping"
  s.version     = SpreeDropShipping::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "https://github.com/citrus/spree_drop_shipping"
  s.summary     = %q{Links products to suppliers and places a combined order with suppliers at the end of the day}
  s.description = %q{TODO}

  s.rubyforge_project = "spree_drop_shipping"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  
  s.require_paths = ["lib"]
  
  # Spree
  s.add_dependency('spree_core', '>= 0.50.2')
  s.add_dependency('spree_auth', '>= 0.50.2')
  
  # Development
  s.add_development_dependency('spree_sample',       '>= 0.50.2')
  s.add_development_dependency('shoulda',            '>= 2.11.3')
	s.add_development_dependency('factory_girl',       '>= 2.0.0.beta2')
	s.add_development_dependency('cucumber',           '>= 0.10.2')
	s.add_development_dependency('capybara',           '>= 0.4.1')
	s.add_development_dependency('selenium-webdriver', '>= 0.1.3')
  s.add_development_dependency('sqlite3',            '>= 1.3.3')
  s.add_development_dependency('faker',              '>= 0.9.5')
  s.add_development_dependency('spork',              '>= 0.9.0.rc5')
  s.add_development_dependency('spork-testunit',     '>= 0.0.5')
  
end