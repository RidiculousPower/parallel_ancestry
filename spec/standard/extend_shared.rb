# -*- encoding : utf-8 -*-

require_relative '../../lib/parallel_ancestry/standard.rb'
require_relative '../setup.rb'

shared_examples_for 'ParallelAncestry::Standard Extend' do

  initialize_base_test_setup

  let( :parallel_ancestry ) { ::ParallelAncestry::Standard }
  
  let( :extending_module )  { ::Module.new.name( :ExtendingModule ) }
  
  let( :module_extended_by_module )   { module_instance.extend( extending_module ).name( :ModuleExtendedByModule ) }
  let( :class_extended_by_module )    { class_instance.extend( extending_module ).name( :ClassExtendedByModule ) }
  let( :subclass_extended_by_module ) { subclass.extend( extending_module ).name( :SubclassExtendedByModule ) }

  let( :instance_of_object_extended_by_module )   { instance_of_object.extend( extending_module ).name( :InstanceOfObjectExtendedByModule ) }
  let( :instance_of_class_extended_by_module )    { instance_of_class.extend( extending_module ).name( :InstanceOfClassExtendedByModule ) }
  let( :instance_of_subclass_extended_by_module ) { instance_of_subclass.extend( extending_module ).name( :InstanceOfSubclassExtendedByModule ) }

  context 'module extended by another module' do
    it 'singleton parents should be [ self, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( module_extended_by_module ).should == [ extending_module, module_instance, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'instance parents should be [ self ]' do
      parallel_ancestry.instance_parents( module_extended_by_module ).should == [ module_instance ]
    end
  end

  context 'class extended by a module' do
    it 'singleton parents should be [ class, extending_module, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( class_extended_by_module ).should == [ extending_module, class_instance, ::Class, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'instance parents should be [ class, Object, PP::ObjectMixin, Kernel, BasicObject ]' do
      parallel_ancestry.instance_parents( class_extended_by_module ).should == [ class_instance, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
  end

  context 'subclass extended by a module' do
    it 'singleton parents should be [ subclass, extending_module, class, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( subclass_extended_by_module ).should == [ extending_module, subclass, class_instance, ::Class, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'instance parents should be [ subclass, class, Object, PP::ObjectMixin, Kernel, BasicObject ]' do
      parallel_ancestry.instance_parents( subclass_extended_by_module ).should == [ subclass, class_instance, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
  end

  context 'instance of Object extended by a module' do
    it 'singleton parents should be [ instance_of_object, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( instance_of_object_extended_by_module ).should == [ extending_module, instance_of_object_extended_by_module, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
    it 'instance parents should be singleton parents' do
      parallel_ancestry.instance_parents( instance_of_object_extended_by_module ).should be parallel_ancestry.parents( instance_of_object_extended_by_module )
    end
  end

  context 'instance of class extended by a module' do
    it 'singleton parents should be [ instance_of_object, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( instance_of_class_extended_by_module ).should == [ extending_module, instance_of_class_extended_by_module, class_instance, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
    it 'instance parents should be singleton parents' do
      parallel_ancestry.instance_parents( instance_of_class_extended_by_module ).should be parallel_ancestry.parents( instance_of_class_extended_by_module )
    end
  end

  context 'instance of sublass extended by a module' do
    it 'singleton parents should be [ instance_of_object, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( instance_of_subclass_extended_by_module ).should == [ extending_module, instance_of_subclass_extended_by_module, subclass, class_instance, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
    it 'instance parents should be singleton parents' do
      parallel_ancestry.instance_parents( instance_of_subclass_extended_by_module ).should be parallel_ancestry.parents( instance_of_subclass_extended_by_module )
    end
  end

end
