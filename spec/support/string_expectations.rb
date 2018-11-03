require "yaml"

class String
	def has_been_created?
		File.directory?(File.expand_path("../../tmp/#{self}", __FILE__))
	end

	def using_inky?
		file = File.expand_path("../../tmp/#{self}/config.yaml", __FILE__)
		config = YAML.load_file(file)
		config["inky"]
	end
end