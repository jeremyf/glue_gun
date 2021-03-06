# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'glue_gun/version'

Gem::Specification.new do |spec|
  spec.name          = "glue_gun"
  spec.version       = GlueGun::VERSION
  spec.authors       = [
    "Jeremy Friesen"
  ]
  spec.email         = [
    "jeremy.n.friesen@gmail.com"
  ]
  spec.description   = <<-EOF
  A tool for connecting parts of your application at configuration time.
  Part thought experiment, part useful, part extensible via plugins.
  EOF
  spec.summary       = %q{A tool for connecting parts of your application at configuration time.}
  spec.homepage      = "https://github.com/jeremyf/glue_gun"
  spec.license       = "APACHE2"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'guard-livereload'

end
