# frozen_string_literal: true

require_relative "lib/jekyll-chatgpt/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll-chatgpt"
  spec.version = JekyllChatgpt::VERSION
  spec.authors = ["pcouy"]
  spec.email = ["contact@pierre-couy.dev"]

  spec.summary = "Display and navigate branching ChatGPT conversations"
  spec.description = "Use OpenAI API JSON as data files and display branching conversations on your website"
  spec.homepage = "https://pierre-couy.dev/projects/jekyll-chatgpt.html"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pcouy/jekyll-chatgpt"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_runtime_dependency "jekyll", "~> 4.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
