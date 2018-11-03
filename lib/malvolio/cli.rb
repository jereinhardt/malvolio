require "thor"
require "rails/generators"

module Malvolio
	class CLI < Thor
		def self.start(args)
			puts args
			super(args)
		end

		option :no_inky, type: :boolean
		desc "new NAME [--no-inky]", "creates a new email project"
		def new(name)
			if options[:no_inky]
				::Rails::Generators.invoke("malvolio:create_without_inky", [name])
			else
				::Rails::Generators.invoke("malvolio:create", [name])
			end
		end
	end
end