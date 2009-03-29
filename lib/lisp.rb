module Lisp
  class Program < Treetop::Runtime::SyntaxNode
    def eval(scope)
      elements.map { |e| e.eval(scope) }.last
    end
  end
  
  class List < Treetop::Runtime::SyntaxNode
    def eval(scope)
      func = cells.first.eval(scope)
      args = cells[1..-1]
      func.call(scope, args)
    end
    
    def cells
      elements[1].elements.map { |c| c.data }
    end
  end
  
  class Cell < Treetop::Runtime::SyntaxNode
    def eval(scope); data.eval(scope); end
    def data; elements[1]; end
  end
  
  module Boolean
    def eval(scope); text_value == '#t'; end
  end
  
  module Integer
    def eval(scope); text_value.to_i; end
  end
  
  class Identifier < Treetop::Runtime::SyntaxNode
    def eval(scope); scope[text_value]; end
  end
end

