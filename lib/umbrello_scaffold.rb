require "umbrello_scaffold/version"
require 'rubygems'
require 'nokogiri'
require 'rails/generators/actions'
#require 'rake'

module UmbrelloScaffold
  
  require 'umbrello_scaffold/railtie' if defined?(Rails)
#  if defined?(Rails)
#    class Railtie < Rails::Railtie
#      railtie_name :umbrello_scaffold
#
#      rake_tasks do
#        load "tasks/umbrello.rake"
#      end
#    end
#  end

#  load "#{File.dirname(__FILE__)}/tasks/umbrello.rake" if defined?(Rake)
#  Dir["lib/tasks/**/*.rake"].each { |ext| load ext } if defined?(Rake)
  
  class Parser

    include Rails::Generators::Actions

    def initialize(file)
      @document = Nokogiri::XML(open(file))
      @datatypes = {}
      @document.xpath('//UML:DataType').each do |datatype|
        @datatype[datatype.attr('xmi.id')] = datatype.attr('name')
      end
      @document.xpath('//UML:Class').each do |datatype|
        @datatype[datatype.attr('xmi.id')] = datatype.attr('name')
      end
    end

    def parse(scaffolds = true, *args)
      @document.xpath('//UML:Entity').each do |entity|
        name = entity.attr('name')
        attrs = []
        is_id = false
        entity.xpath('//UML:EntityAttribute') do |attribute|
          if attribute.attr('name') == 'id'
            is_id = true
          else
            attrs << "#{attribute.attr(name)}:#{@datatypes[attribute.attr('type')]}"
          end
        end
        what =  (scaffolds && is_id) ? 'scaffold' : 'model'
        generate(what, *([name] + attrs + args))
      end
    end

  end

end
