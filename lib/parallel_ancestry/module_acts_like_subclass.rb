# -*- encoding : utf-8 -*-

unless ::Object.const_defined?( :ParallelAncestry )
  require_relative '../parallel_ancestry.rb'
end

module ::ParallelAncestry::ModuleActsLikeSubclass
end

[
  'module_acts_like_subclass/register',
  'module_acts_like_subclass/unregister'
].each { |this_file| require_relative( this_file << '.rb' ) }

module ::ParallelAncestry::ModuleActsLikeSubclass
  ::ParallelAncestry.suspend do
    extend ::ParallelAncestry::Common
    extend ::ParallelAncestry::ModuleActsLikeSubclass::Register
    extend ::ParallelAncestry::ModuleActsLikeSubclass::Unregister
    ::ParallelAncestry.register_module( self )
  end
end

