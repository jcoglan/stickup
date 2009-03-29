class Function
  def initialize(&block)
    @body = block
  end
  
  def call(*args)
    @body.call(*args)
  end
end

