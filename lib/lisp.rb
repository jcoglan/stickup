module Lisp
  class Program < Treetop::Runtime::SyntaxNode
    def eval(scope)
      elements.map { |e| e.eval(scope) }.last
    end
  end
  
  class List < Treetop::Runtime::SyntaxNode
  end
  
  class Cell < Treetop::Runtime::SyntaxNode
  end
  
  module Boolean
  end
  
  module Integer
  end
  
  class Identifier < Treetop::Runtime::SyntaxNode
  end
end

