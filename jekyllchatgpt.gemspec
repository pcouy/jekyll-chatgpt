# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "jekyll-chatgpt-demo"
  spec.version       = "1.0.0"
  spec.authors       = ["Pierre Couy"]
  spec.email         = ["couy.pierre@gmail.com"]

  spec.summary       = ""
  spec.homepage      = "https://github.com/pcouy/jekyll-chatgpt"
  spec.license       = "All rights reserved"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README|CHANGELOG)!i) }

  spec.add_runtime_dependency "jekyll", "~> 4.2"
end
