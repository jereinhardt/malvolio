require "spec_helper"

RSpec.describe Malvolio::CLI do
	describe "#new" do
		let(:project_name) { "new_project" }

		around(:each) do |example|
			Dir.chdir(File.expand_path("../../tmp", __FILE__))
			example.run
			if File.directory?(File.expand_path("../../tmp/#{project_name}", __FILE__))
				FileUtils.rm_rf(File.expand_path("../../tmp/#{project_name}", __FILE__))
			end
		end

		it "creates a new project with inky" do
			executable_path = File.expand_path("../../../bin/malvolio", __FILE__)
			Malvolio::CLI.start(["new", project_name])
			
			expect(project_name).to have_been_created
			expect(project_name).to be_using_inky
		end

		it "creates a new project without inky" do
			executable_path = File.expand_path("../../../bin/malvolio", __FILE__)
			Malvolio::CLI.start(["new", project_name, "--no-inky"])

			expect(project_name).to have_been_created
			expect(project_name).not_to be_using_inky
		end
	end
end