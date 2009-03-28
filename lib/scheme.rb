require 'rubygems'
require 'treetop'

Treetop.load File.dirname(__FILE__) + '/lisp.tt'
require File.dirname(__FILE__) + '/lisp.rb'

module Scheme
  def self.run(path)
    tree = parse(File.read path)
    tree.eval
  end
  
  def self.parse(string)
    @parser ||= LispParser.new
    @parser.parse(string)
  end
end

