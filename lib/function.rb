class Function
  def initialize(scope, formals = [], body = nil, &block)
    @scope = scope
    @formals = formals.map { |f| f.to_s }
    @body = body || block
  end
  
  def call(scope, args)
    args = args.map { |a| a.eval(scope) }
    return @body.call(*args) if primitive?
    closure = Scope.new(@scope)
    @formals.each_with_index { |name, i| closure[name] = args[i] }
    @body.map { |expr| expr.eval(closure) }.last
  end
  
  def primitive?
    Proc === @body
  end
end

class Syntax < Function
  def call(scope, args)
    @body.call(scope, args)
  end
end

