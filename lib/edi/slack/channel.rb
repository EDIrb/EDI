module Slack
  class Channel
    attr_accessor :id, :name
    def initialize(id:, name:)
      @id = id
      @name = name
    end

    def self.find_by_name(name)
      EDI.channels.find { |c| c.name == name }
    end

    def self.find_by_id(id)
      EDI.channels.find { |c| c.id == id }
    end

  end
end
