module PuppetStrings::Yard::Parsers::JSON
  # Represents the Puppet Task statement.
  class TaskStatement
    attr_reader :line, :comments, :comments_range, :json, :file, :source

    def initialize(json, source, file)
      @file = file
      @source = source
      @json = json
      @line = 0
      @comments_range = nil
    end

    def docstring
      YARD::Docstring.new(json['description'] || "")
    end

    def parameters
      json['parameters'] || {}
    end

    def comments_hash_flag
      false
    end

    def show
      ""
    end

    def comments
      ""
    end

    def name
      File.basename(@file).gsub('.json','') || ""
    end
  end
end
