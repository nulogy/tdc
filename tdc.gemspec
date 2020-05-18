require_relative "lib/tdc/version"

Gem::Specification.new do |spec|
  spec.name = "tdc"
  spec.version = Tdc::VERSION
  spec.authors = ["Alistair McKinnell"]
  spec.email = ["alistairm@nulogy.com"]

  spec.summary = "A simple framework for creating a Test Data Catalog"
  spec.homepage = "https://github.com/nulogy/tdc"

  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata = {
    "homepage_uri" => "https://github.com/nulogy/tdc",
    "changelog_uri" => "https://github.com/nulogy/tdc/blob/master/CHANGELOG.md",
    "source_code_uri" => "https://github.com/nulogy/tdc",
    "bug_tracker_uri" => "https://github.com/nulogy/tdc/issues"
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", "~> 5.2.4"

  spec.add_development_dependency "rake", ">= 12.1", "< 13.1"
  spec.add_development_dependency "rspec", ">= 3.9", "< 4.0"
  spec.add_development_dependency "rubocop", "~> 0.82"
  spec.add_development_dependency "rubocop-rspec", "~> 1.38"
  spec.add_development_dependency "simplecov", "~> 0.17"
end
