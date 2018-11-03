
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "malvolio/version"

Gem::Specification.new do |spec|
  spec.name          = "malvolio"
  spec.version       = Malvolio::VERSION
  spec.authors       = ["Josh Reinhardt"]
  spec.email         = ["jereinhardt415@gmail.com"]

  spec.summary       = %q{A command line tool for building HTML emails.}
  spec.description   = %q{A command line tool for building HTML emails.}
  spec.homepage      = "https://github.com/jereinhardt/malvolio"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/jereinhardt/malvolio"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "inky-rb"
  spec.add_dependency "premailer"
  spec.add_dependency "filewatcher"
  spec.add_dependency "compass"
  spec.add_dependency "sass"

  spec.add_development_dependency "rails"
  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
