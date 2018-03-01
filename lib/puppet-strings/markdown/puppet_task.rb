require 'puppet-strings/markdown/base'

module PuppetStrings::Markdown
  class PuppetTask < Base

    def initialize(registry)
      @template = 'puppet_task.erb'
      super(registry, 'task')
    end

    def render
      super(@template)
    end
  end
end
