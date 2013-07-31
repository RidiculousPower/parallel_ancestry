# -*- encoding : utf-8 -*-

require_relative '../../lib/parallel_ancestry.rb'
require_relative '../setup.rb'

describe 'ParallelAncestry::Standard Extend' do
  
  initialize_test_setup
  
  context 'module extended by another module' do
    it 'singleton parents should be [ self, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( module_extended_by_module ).should == [ module_instance, extending_module, ::Module, ::ParallelAncestry::Enable::IncludedExtended, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'instance parents should be [ self ]' do
      parallel_ancestry.instance_parents( module_extended_by_module ).should == [ module_instance ]
    end
  end

  context 'class extended by a module' do
    it 'singleton parents should be [ class, extending_module, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( class_extended_by_module ).should == [ class_instance, extending_module, ::ParallelAncestry::Enable::IncludedExtended, ::Class, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'instance parents should be [ class, Object, PP::ObjectMixin, Kernel, BasicObject ]' do
      parallel_ancestry.instance_parents( class_extended_by_module ).should == [ class_instance, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
  end

  context 'subclass extended by a module' do
    it 'singleton parents should be [ subclass, extending_module, class, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( subclass_extended_by_module ).should == [ subclass, extending_module, ::ParallelAncestry::Enable::IncludedExtended, class_instance, ::Class, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'instance parents should be [ subclass, class, Object, PP::ObjectMixin, Kernel, BasicObject ]' do
      parallel_ancestry.instance_parents( subclass_extended_by_module ).should == [ subclass, class_instance, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
  end

  context 'instance of Object extended by a module' do
  end

  context 'instance of Class instance extended by a module' do
  end

  context 'instance of Sublass extended by a module' do
  end
  
end
