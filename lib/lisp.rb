module Lisp
  class Program < Treetop::Runtime::SyntaxNode
    def eval
      elements.map { |e| e.eval }.last
    end
  end
  
  class Cell < Treetop::Runtime::SyntaxNode
    def eval; elements[1].eval; end
  end
  
  module Boolean
    def eval; text_value == '#t'; end
  end
  
  module Integer
    def eval; text_value.to_i; end
  end
end

