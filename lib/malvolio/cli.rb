require "thor"
require "rails/generators"

module Malvolio
	class CLI < Thor
		option :no_inky, type: :boolean
		desc "new NAME [--no-inky]", "creates a new email project"
		def new(name)
			if options[:no_inky]
				::Rails::Generators.invoke("malvolio:create_without_inky", [name])
			else
				::Rails::Generators.invoke("malvolio:create", [name])
			end
		end

		option :no_warnings, type: :boolean
		desc "build [PATH] [--no-warnings]", "compile the project to a finished HTML email"
		def build(path = nil)
			Malvolio::Compiler.new(path, options[:no_warnings]).run!
		end

		option :no_warnings, type: :boolean
		desc "watch [PATH] [--no-warnings]", "watch the project files and build and file changes"
		def watch(path = nil)
		end
	end
end