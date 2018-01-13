$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'frgom/version'

Gem::Specification.new do |s|
  s.name = 'frgom'
  s.version = Frgom::VERSION
  s.authors = ['Daniel Doubrovkine']
  s.email = 'dblock@dblock.org'
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.6'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
  s.homepage = 'http://github.com/dblock/frgom'
  s.licenses = ['MIT']
  s.summary = 'First ruby gem of many.'
end
