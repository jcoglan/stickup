require 'forwardable'

class Scope
  def initialize(parent = nil)
    @parent = parent || {}
    @symbols = {}
  end
  
  def [](name)
    @symbols[name] || @parent[name]
  end
  
  def []=(name, value)
    @symbols[name] = value
  end
end

class TopLevel < Scope
  def initialize(*args)
    super
    self['+'] = Function.new { |arg1, arg2| arg1 + arg2 }
  end
end 

