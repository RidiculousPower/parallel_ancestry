# -*- encoding : utf-8 -*-

unless ::Object.const_defined?( :ParallelAncestry )
  require_relative '../parallel_ancestry.rb'
end

module ::ParallelAncestry::Standard
  ::ParallelAncestry.suspend do
    extend ::ParallelAncestry::Common
    ::ParallelAncestry.register_module( self )
  end
end

