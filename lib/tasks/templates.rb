require 'erb'
require 'fileutils'

OUTPUT_DIR = 'lib/template_out'

module Mailadm
  class TemplateValues

    def initialize(hash)
      hash.each do |key, value|
        singleton_class.send(:define_method, key) { value }
      end
    end

    def get_binding
      binding
    end
  end
end

def convert_from_erb(conf_templates)
  conf_templates.each do |conf_file|
    template = File.read( conf_file )
    data = File.open(Mailadm::Util::PathHelper.absolute_path("lib/config/database.yml"), "r") { |file| YAML.load(file) }
    ts = Mailadm::TemplateValues.new(data)
    config = ERB.new( template, 0, '-' )
    File.open("#{OUTPUT_DIR}/#{conf_file.sub('.erb', '').sub('lib/templates/', '')}", "w") { |file| file.write(config.result( ts.get_binding )) }
  end
end

def create_dirs(directories)
  FileUtils.mkdir_p OUTPUT_DIR
  directories.each do |dir|
    FileUtils.mkdir_p "#{OUTPUT_DIR}/#{dir.sub('lib/templates/', '')}"
  end
end


namespace :templates do
  desc 'Generates Templates located in templates directory for upload to server'
  task :generate do
    dirs = Dir.glob('lib/templates/**/*/').select {|f| File.directory? f }

    templates = Dir.glob("lib/templates/**/*.erb")
    create_dirs(dirs)
    convert_from_erb(templates)
  end
end
