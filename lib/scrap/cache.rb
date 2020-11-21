require 'singleton'

class Scrap::Cache
  include Singleton

  def self.get(key)
    instance.get(key)
  end

  def self.set(key, value)
    instance.set(key, value)
  end

  def initialize
    @store = {}
  end

  def get(key)
    @store[key]
  end

  def set(key, value)
    @store[key] = value
  end
end
