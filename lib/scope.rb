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
  
  def define(name, *args, &block)
    self[name] = Function.new(self, *args, &block)
  end
  
  def syntax(name, &block)
    self[name] = Syntax.new(self, &block)
  end
end

class TopLevel < Scope
  def initialize(*args)
    super
    
    syntax('define') do |scope, cells|
      first = cells.first
      case first
        when Lisp::List
          names = first.cells.map { |c| c.text_value }
          scope.define(names.first, names[1..-1], cells[1..-1])
        when Lisp::Identifier
          scope[first.text_value] = cells[1].eval(scope)
      end
    end
    
    syntax('lambda') do |scope, cells|
      names = cells.first.cells.map { |c| c.text_value }
      Function.new(scope, names, cells[1..-1])
    end
    
    syntax('if') do |scope, cells|
      which = cells.first.eval(scope) ? cells[1] : cells[2]
      which.eval(scope)
    end
    
    define('+') { |arg1, arg2| arg1 + arg2 }
    define('-') { |arg1, arg2| arg1 - arg2 }
    define('*') { |arg1, arg2| arg1 * arg2 }
    define('/') { |arg1, arg2| arg1 / arg2 }
    define('=') { |arg1, arg2| arg1 == arg2 }
    
    define('display') { |x| puts x }
  end
end 

