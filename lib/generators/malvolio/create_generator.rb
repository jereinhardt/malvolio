require "rails/generators"

module Malvolio
	module Generators
		class CreateGenerator < Rails::Generators::Base
			source_root File.join(File.dirname(__FILE__), "templates", "base")
			argument :project_name, type: :string

			def create_html_file
				template "index.html", File.join(project_name, "src", "index.html")
			end

			def create_css_file 
				template "index.scss", File.join(project_name, "src", "scss", "index.scss")
			end

			def create_config_file
				template "config.yaml", File.join(project_name, "config.yaml")
			end

			def create_dist_and_tmp_dirs
				Dir.mkdir File.join(project_name, "dist")
				Dir.mkdir File.join(project_name, "tmp")
			end
		end
	end
end