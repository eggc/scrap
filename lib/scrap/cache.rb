require 'singleton'

class Scrap::Cache
  include Singleton

  class << self
    def get(key)
      instance.store[key]
    end

    def set(key, value)
      instance.store[key] = value
    end

    def clear
      instance.store = {}
    end
  end

  attr_accessor :store

  def initialize
    @store = {}
  end
end
