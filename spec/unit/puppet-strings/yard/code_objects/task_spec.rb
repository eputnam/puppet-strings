require 'spec_helper'
require 'puppet-strings/yard/code_objects/task'
require 'puppet-strings/yard/parsers/json/task_statement'

describe PuppetStrings::Yard::CodeObjects::Task do
  let(:source) { <<-SOURCE
{
  "description": "Allows you to backup your database to local file.",
  "input_method": "stdin",
  "parameters": {
    "database": {
      "description": "Database to connect to",
      "type": "Optional[String[1]]"
    },
    "user": {
      "description": "The user",
      "type": "Optional[String[1]]"
    },
    "password": {
      "description": "The password",
      "type": "Optional[String[1]]"
    },
     "sql": {
      "description": "Path to file you want backup to",
      "type": "String[1]"
    }
  }
}
SOURCE
  }
  let(:json) { JSON.parse(source) }
  let(:statement) { PuppetStrings::Yard::Parsers::JSON::TaskStatement.new(json, source, "test.json") }
  subject { PuppetStrings::Yard::CodeObjects::Task.new(statement) }

  describe '#type' do
    it 'returns the correct type' do
      expect(subject.type).to eq(:puppet_task)
    end
  end

  describe '#source' do
    it 'returns the source' do
      expect(subject.source).to eq(source)
    end
  end

  describe '#to_hash' do
    let(:expected) do
      { :name => "test",
        "description" => "Allows you to backup your database to local file.",
        "input_method" => "stdin",
        "parameters" =>
        {"database" => {
            "description" => "Database to connect to",
            "type" => "Optional[String[1]]"
          },
          "user"=> {
            "description"=>"The user",
            "type"=>"Optional[String[1]]"
          },
          "password"=> {
            "description"=>"The password",
            "type"=>"Optional[String[1]]"
          },
          "sql"=> {
            "description"=>"Path to file you want backup to",
            "type"=>"String[1]"
          }
        }
      }
    end

    it 'returns the correct hash' do
      expect(subject.to_hash).to eq(expected)
    end
  end
end
