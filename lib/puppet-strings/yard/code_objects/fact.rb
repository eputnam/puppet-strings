require 'puppet-strings/yard/code_objects/group'

# Implements the group for Puppet functions.
class PuppetStrings::Yard::CodeObjects::Facts < PuppetStrings::Yard::CodeObjects::Group
  # Gets the singleton instance of the group.
  # @param [Symbol] type The function type to get the group for.
  # @return Returns the singleton instance of the group.
  def self.instance
    super(:fact)
  end

  # Gets the display name of the group.
  # @param [Boolean] prefix whether to show a prefix. Ignored for Puppet group namespaces.
  # @return [String] Returns the display name of the group.
  def name(prefix = false)
    'Facts'
  end
end

# Implements the Puppet function code object.
class PuppetStrings::Yard::CodeObjects::Fact < PuppetStrings::Yard::CodeObjects::Base

  # Initializes a Puppet function code object.
  # @param [String] name The name of the function.
  # @param [Symbol] function_type The type of function (e.g. :ruby3x, :ruby4x, :puppet)
  # @return [void]
  def initialize(name, statement)
    @name = name
    super(PuppetStrings::Yard::CodeObjects::Facts.instance, name)
  end

  # Gets the type of the code object.
  # @return Returns the type of the code object.
  def type
    :fact
  end

  # Converts the code object to a hash representation.
  # @return [Hash] Returns a hash representation of the code object.
  def to_hash
    hash = {}

    hash[:name] = name
    hash[:file] = file
    hash[:line] = line
    hash[:docstring] = PuppetStrings::Json.docstring_to_hash(docstring)
    hash[:source] = source unless source && source.empty?
    hash
  end
end
