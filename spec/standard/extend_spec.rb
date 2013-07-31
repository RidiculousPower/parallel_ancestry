# -*- encoding : utf-8 -*-

require_relative '../../lib/parallel_ancestry.rb'
require_relative '../support/named_class_and_module.rb'

describe 'ParallelAncestry::Standard Extend' do
  
  let( :parallel_ancestry ) { ::ParallelAncestry::Standard }
  let( :extending_module ) { ::Module.new.name( :ExtendingModule ) }
  let( :module_instance ) do
    module_instance = ::Module.new.name( :ModuleInstance )
    module_instance.extend( extending_module )
    module_instance
  end

  context 'Module instance' do
    it 'singleton parents should be [ self, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( module_instance ).should == [ module_instance, extending_module, Module, Object, Kernel, BasicObject ]
    end
    it 'instance parents should be [ self ]' do
      parallel_ancestry.instance_parents( module_instance ).should == [ module_instance ]
    end
  end

  context 'Module instance extended by another module' do
    it 'singleton parents should be [ ]' do
    end
    it 'instance parents should be [ ]' do
    end
  end

  context 'Class instance extended by a module' do
  end

  context 'Object instance extended by a module' do
  end
  
end
