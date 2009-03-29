module Lisp
  class Program < Treetop::Runtime::SyntaxNode
    def eval(scope)
      elements.map { |e| e.eval(scope) }.last
    end
  end
  
  class List < Treetop::Runtime::SyntaxNode
    def eval(scope)
      cells = elements[1].elements
      func = cells.first.eval(scope)
      args = cells[1..-1].map { |c| c.eval(scope) }
      func.call(*args)
    end
  end
  
  class Cell < Treetop::Runtime::SyntaxNode
    def eval(scope); elements[1].eval(scope); end
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

