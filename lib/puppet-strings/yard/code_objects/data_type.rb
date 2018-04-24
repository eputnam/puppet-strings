require 'puppet-strings/yard/code_objects/group'

# Implements the group for Puppet defined types.
class PuppetStrings::Yard::CodeObjects::DataTypes < PuppetStrings::Yard::CodeObjects::Group
  # Gets the singleton instance of the group.
  # @return Returns the singleton instance of the group.
  def self.instance
    super(:puppet_data_types)
  end

  # Gets the display name of the group.
  # @param [Boolean] prefix whether to show a prefix. Ignored for Puppet group namespaces.
  # @return [String] Returns the display name of the group.
  def name(prefix = false)
    'Data Types'
  end
end

# Implements the Puppet defined type code object.
class PuppetStrings::Yard::CodeObjects::DataType < PuppetStrings::Yard::CodeObjects::Base
  attr_reader :statement
  attr_reader :parameters

  # Initializes a Puppet defined type code object.
  # @param [PuppetStrings::Parsers::DefinedTypeStatement] statement The defined type statement that was parsed.
  # @return [void]
  def initialize(statement)
    @statement = statement
    super(PuppetStrings::Yard::CodeObjects::DataTypes.instance, statement.name)
  end

  # Gets the type of the code object.
  # @return Returns the type of the code object.
  def type
    :puppet_data_type
  end

  # Gets the type definition
  # @return String describing the data type definition
  def type_def
    @statement.type_def
  end

  # Gets the source of the code object.
  # @return Returns the source of the code object.
  def source
    @statement.source
  end

  # Converts the code object to a hash representation.
  # @return [Hash] Returns a hash representation of the code object.
  def to_hash
    hash = {}
    hash[:name] = name
    hash[:file] = file
    hash[:line] = line
    hash[:type_def] = type_def
    hash[:docstring] = PuppetStrings::Json.docstring_to_hash(docstring)
    hash[:source] = source unless source && source.empty?
    hash
  end
end
