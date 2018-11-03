require "yaml"
require "inky"
require "sass/plugin"
require "premailer"

module Malvolio
	class Compiler
		def initialize(path = nil, no_warnings = false)
			@path = File.expand_path(path || ".")
			@config = YAML.load_file(File.join(@path, "config.yaml"))
			@compiler = Sass::Plugin::Compiler.new
			@compiler.on_compilation_error do |error, template, _css|
				print_compilation_error(error, template)
			end
			@no_warnings = no_warnings
		end

		def run!
			convert_html			
			compile_sass_to_css
			inline_styles
			clean_tmp_folder
			print_colorized("New HTML email build was a success!", 32)
		end

		private

		attr_reader :path, :config, :compiler, :no_warnings

		def convert_html
			src_path = File.join(path, "src", "index.html")
			dest_path = File.join(path, "tmp", "index.html")
			if config["inky"]
				html_string = File.read(src_path)
				html_output = Inky::Core.new.release_the_kraken(html_string)
				File.write(dest_path, html_output)
			else
				FileUtils.cp(src_path, dest_path)
			end
		end

		def compile_sass_to_css
			src_path = File.join(path, "src", "scss", "index.scss")
			dest_path = File.join(path, "tmp", "index.css")
			compiler.update_stylesheets([[src_path, dest_path]])
		end

		def inline_styles
			src_path = File.join(path, "tmp", "index.html")
			dist_path = File.join(path, "dist", "index.html")
			warn_level = no_warnings ? Premailer::Warnings::NONE : Premailer::Warnings::SAFE
			premailer = Premailer.new(src_path, warn_level: warn_level)
			File.open(dist_path, "w") do |file|
				file.puts premailer.to_inline_css
			end
			premailer.warnings.each do |warning|
				print_premailer_warning(warning)
			end
		end

		def clean_tmp_folder
			remove_path = Dir[File.join(path, "tmp", "*")]
			FileUtils.rm_rf(remove_path)
		end

		def print_compilation_error(error, template)
			print_colorized("Sass failed to compile. Error found in #{template}", 31)
			print_colorized(error, 33)
		end

		def print_colorized(string, code)
			puts "\e[#{code}m#{string}\e[0m"
		end

		def print_premailer_warning(warning)
			message = "(#{warning[:level]}) #{warning[:message]} may not render properly "\
				"in the following clients:\n\t#{warning[:clients]}"
			code = premailer_risk_color_codes[warning[:level]]
			print_colorized(message, code)
		end

		def premailer_risk_color_codes
			{"SAFE" => 32, "NONE" => 32, "POOR" => 33, "RISKY" => 31}
		end
	end
end