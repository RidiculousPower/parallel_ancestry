# -*- encoding : utf-8 -*-

require_relative '../lib/parallel_ancestry.rb'

#class ::ParallelAncestry::MockClass
#end
#class ::ParallelAncestry::MockSubclass < ::ParallelAncestry::MockClass
#end

module ::ParallelAncestry::MockModule
end
module ::ParallelAncestry::MockModuleIncludingModule
  include ::ParallelAncestry::MockModule
end
#module ::ParallelAncestry::MockModuleExtendedByModule
#  extend ::ParallelAncestry::MockModule
#end
#class ::ParallelAncestry::MockClassIncludingModule
#  include ::ParallelAncestry::MockModule
#end
#class ::ParallelAncestry::MockClassExtendedByModule
#  extend ::ParallelAncestry::MockModule
#end
#
#class ::ParallelAncestry::MockModuleClass < ::Module
#end
#::ParallelAncestry::InstanceOfMockModuleClass = ::ParallelAncestry::MockModuleClass.new
#module ::ParallelAncestry::MockModuleIncludingInstanceOfModuleClass
#  include ::ParallelAncestry::InstanceOfMockModuleClass
#end
#module ::ParallelAncestry::MockModuleExtendedByInstanceOfModuleClass
#  extend ::ParallelAncestry::InstanceOfMockModuleClass
#end
#class ::ParallelAncestry::MockClassIncludingInstanceOfModuleClass
#  include ::ParallelAncestry::InstanceOfMockModuleClass
#end
#class ::ParallelAncestry::MockClassExtendedByInstanceOfModuleClass
#  extend ::ParallelAncestry::InstanceOfMockModuleClass
#end
#
#class ::ParallelAncestry::MockModuleSubclass < ::ParallelAncestry::MockModuleClass
#end
#::ParallelAncestry::InstanceOfMockModuleSubclass = ::ParallelAncestry::MockModuleSubclass.new
#module ::ParallelAncestry::MockModuleIncludingInstanceOfModuleSubclass
#  include ::ParallelAncestry::InstanceOfMockModuleSubclass
#end
#module ::ParallelAncestry::MockModuleExtendedByInstanceOfModuleSubclass
#  extend ::ParallelAncestry::InstanceOfMockModuleSubclass
#end
#class ::ParallelAncestry::MockClassIncludingInstanceOfModuleSubclass
#  include ::ParallelAncestry::InstanceOfMockModuleSubclass
#end
#class ::ParallelAncestry::MockClassExtendedByInstanceOfModuleSubclass
#  extend ::ParallelAncestry::InstanceOfMockModuleSubclass
#end

describe ::ParallelAncestry do

  #let( :instance_of_object ) { ::Object.new }
  #
  #let( :class_instance ) { ::ParallelAncestry::MockClass }
  #let( :instance_of_class ) { ::ParallelAncestry::MockClass.new }
  #
  #let( :subclass ) { ::ParallelAncestry::MockSubclass }
  #let( :instance_of_subclass ) { ::ParallelAncestry::MockSubclass.new }
  #
  let( :module_instance ) { ::ParallelAncestry::MockModule }
  #let( :module_extended_by_module ) { ::ParallelAncestry::MockModuleExtendedByModule }
  let( :module_including_module ) { ::ParallelAncestry::MockModuleIncludingModule }
  #let( :class_extended_by_module ) { ::ParallelAncestry::MockClassExtendedByModule }
  #let( :class_including_module ) { ::ParallelAncestry::MockClassIncludingModule }
  #
  #let( :module_class ) { ::ParallelAncestry::MockModuleClass }
  #let( :instance_of_module_class ) { ::ParallelAncestry::InstanceOfMockModuleClass }
  #let( :module_extended_by_instance_of_module_class ) { ::ParallelAncestry::MockModuleExtendedByInstanceOfModuleClass }
  #let( :module_including_instance_of_module_class ) { ::ParallelAncestry::MockModuleIncludingInstanceOfModuleClass }
  #let( :class_extended_by_instance_of_module_class ) { ::ParallelAncestry::MockClassExtendedByInstanceOfModuleClass }
  #let( :class_including_instance_of_module_class ) { ::ParallelAncestry::MockClassIncludingInstanceOfModuleClass }
  #
  #let( :module_subclass ) { ::ParallelAncestry::MockModuleSubclass }
  #let( :instance_of_module_subclass ) { ::ParallelAncestry::InstanceOfMockModuleSubclass }
  #let( :module_extended_by_instance_of_module_subclass ) { ::ParallelAncestry::MockModuleExtendedByInstanceOfModuleSubclass }
  #let( :module_including_instance_of_module_subclass ) { ::ParallelAncestry::MockModuleIncludingInstanceOfModuleSubclass }
  #let( :class_extended_by_instance_of_module_subclass ) { ::ParallelAncestry::MockClassExtendedByInstanceOfModuleSubclass }
  #let( :class_including_instance_of_module_subclass ) { ::ParallelAncestry::MockClassIncludingInstanceOfModuleSubclass }

  #it 'Object is manually registered as child of Class' do
  #  ::ParallelAncestry.is_instance_parent?( ::Object, ::Class ).should be true
  #end
  #
  #context 'class, subclass, instance' do
  #
  #  it 'will register a new class' do
  #    ::ParallelAncestry.is_instance_parent?( class_instance, ::Object ).should be true
  #  end
  #
  #  it 'will register a new instance of class' do
  #    ::ParallelAncestry.is_singleton_parent?( instance_of_class, class_instance ).should be true
  #  end
  #
  #  it 'will register subclass of a new class' do
  #    ::ParallelAncestry.is_instance_parent?( subclass, class_instance ).should be true
  #  end
  #
  #  it 'will register a new instance of subclass' do
  #    ::ParallelAncestry.is_singleton_parent?( instance_of_subclass, subclass ).should be true
  #  end
  #
  #end
  
  context 'module' do

    #it 'will register a new module' do
    #  ::ParallelAncestry.is_singleton_parent?( module_instance, ::Module ).should be true
    #end
    
    it 'will register a module that includes module' do
      ::ParallelAncestry.is_instance_parent?( module_including_module, module_instance ).should be true
    end
    
    #it 'will register a class that includes module' do
    #  ::ParallelAncestry.is_instance_parent?( class_including_module, module_instance ).should be true
    #end
    #
    #it 'will register a module that extends module' do
    #  ::ParallelAncestry.is_singleton_parent?( module_extended_by_module, module_instance ).should be true
    #end
    #
    #it 'will register a class that extends module' do
    #  ::ParallelAncestry.is_singleton_parent?( class_extended_by_module, module_instance ).should be true
    #end

  end
  
  #context 'class < Module' do
  #
  #  it 'will register a new class < Module' do
  #    ::ParallelAncestry.is_instance_parent?( module_class, ::Module ).should be true
  #  end
  #
  #  it 'will register instance of a class < Module' do
  #    ::ParallelAncestry.is_singleton_parent?( instance_of_module_class, module_class ).should be true
  #  end
  #
  #  it 'will register subclass of a new class < Module' do
  #    ::ParallelAncestry.is_instance_parent?( module_subclass, module_class ).should be true
  #  end
  #
  #  it 'will register instance of a subclass class < Module' do
  #    ::ParallelAncestry.is_singleton_parent?( instance_of_module_subclass, module_subclass ).should be true
  #  end
  #  
  #end
  #
  #context 'Object' do
  #
  #  it 'will register a new instance of Object' do
  #    ::ParallelAncestry.is_singleton_parent?( instance_of_object, ::Object ).should be true
  #  end
  #
  #end
  
end
