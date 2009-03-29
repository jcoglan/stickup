class Function
  def initialize(formals = [], body = nil, &block)
    @formals = formals.map { |f| f.to_s }
    @body = body || block
  end
  
  def call(scope, args)
    args = args.map { |a| a.eval(scope) }
    return @body.call(*args) if primitive?
    @formals.each_with_index { |name, i| scope[name] = args[i] }
    @body.map { |expr| expr.eval(scope) }.last
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

