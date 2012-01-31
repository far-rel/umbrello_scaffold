# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "umbrello_scaffold/version"

Gem::Specification.new do |s|
  s.name        = "umbrello_scaffold"
  s.version     = UmbrelloScaffold::VERSION
  s.authors     = ["Paweł Tarczykowski"]
  s.email       = ["farrel1@wp.pl"]
  s.homepage    = ""
  s.summary     = "Umbrello file import"
  s.description = "Gem that generates scaffolds or models from Umbrello .xmi files"
  
  s.add_dependency 'nokogiri'

  s.rubyforge_project = "umbrello_scaffold"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
