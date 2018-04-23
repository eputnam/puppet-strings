require 'puppet-strings/yard/handlers/helpers'
require 'puppet-strings/yard/handlers/ruby/base'
require 'puppet-strings/yard/code_objects'
require 'puppet-strings/yard/util'

# Implements the handler for Facts written in Ruby.
class PuppetStrings::Yard::Handlers::Ruby::FactHandler < PuppetStrings::Yard::Handlers::Ruby::Base

  namespace_only
  handles method_call(:add)

  process do
    # Only accept calls to Facter.
    return unless statement.count > 1
    module_name = statement[0].source
    return unless module_name == 'Facter'

    object = PuppetStrings::Yard::CodeObjects::Fact.new(get_name, statement)
    register object
  end

  private
   def get_name
     parameters = statement.parameters(false)
     raise YARD::Parser::UndocumentableError, "Expected at least one parameter to Facter.add at #{statement.file}:#{statement.line}." if parameters.empty?
     name = node_as_string(parameters.first)
     raise YARD::Parser::UndocumentableError, "Expected a symbol or string literal for the fact name but found '#{parameters.first.type}' at #{statement.file}:#{statement.line}." unless name
     name
   end
end
