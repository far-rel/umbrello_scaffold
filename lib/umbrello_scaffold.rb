require "umbrello_scaffold/version"
require 'rubygems'
require 'nokogiri'

module UmbrelloScaffold
  
  require 'umbrello_scaffold/railtie' if defined?(Rails)
  
  class Parser

    def initialize(file)
      @document = Nokogiri::XML(open(file))
      @datatypes = {}
      @document.xpath('//UML:DataType').each do |datatype|
        @datatypes[datatype.attr('xmi.id')] = datatype.attr('name')
      end
      @document.xpath('//UML:Class').each do |datatype|
        @datatypes[datatype.attr('xmi.id')] = datatype.attr('name')
      end
    end

    def parse(scaffolds = true, *args)
      @document.xpath('//UML:Entity').each do |entity|
        name = entity.attr('name')
        attrs = []
        is_id = false
        
        Nokogiri::XML(entity.to_xml).xpath('//EntityAttribute').each do |attribute|
          if attribute.attr('name') == 'id'
            is_id = true
          else
            attrs << "#{attribute.attr('name')}:#{@datatypes[attribute.attr('type')]}"
          end
        end
        what =  (scaffolds && is_id) ? 'scaffold' : 'model'
        
        system "rails generate #{what} #{name} #{attrs.join ' '} #{args.join ' '}"
      end
    end

  end

end
