require 'rubygems'
require 'treetop'

Treetop.load File.dirname(__FILE__) + '/lisp.treetop'
%w[lisp scope function].each { |path| require File.dirname(__FILE__) + '/' + path }

module Scheme
  def self.run(path)
    tree = parse(File.read path)
    scope = TopLevel.new
    tree.eval(scope)
  end
  
  def self.parse(string)
    @parser ||= LispParser.new
    @parser.parse(string)
  end
end

