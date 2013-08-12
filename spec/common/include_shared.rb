# -*- encoding : utf-8 -*-

shared_examples_for 'ParallelAncestry Include' do

  initialize_base_test_setup

  let( :module_to_include )  { ::Module.new.name( :ExtendingModule ) }
  
  let( :module_including_module ) do
    _module_to_include = module_to_include
    module_instance.module_eval { include( _module_to_include ) }.name( :ModuleExtendedByModule )
  end
  let( :class_including_module ) do
    _module_to_include = module_to_include
    class_instance.class_eval { include( _module_to_include ) }.name( :ClassExtendedByModule )
  end
  let( :subclass_including_module ) do
    _module_to_include = module_to_include
    subclass.class_eval { include( _module_to_include ) }.name( :SubclassExtendedByModule )
  end
  
  context 'module including another module' do
    it 'instance parents should be [ module ]' do
      parallel_ancestry.instance_parents( module_including_module ).should == [ module_instance, module_to_include ]
    end
  end

  context 'class including module' do
    it 'instance parents should be [ class, Object, PP::ObjectMixin, Kernel, BasicObject ]' do
      parallel_ancestry.instance_parents( class_including_module ).should == [ class_instance, module_to_include, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
  end

  context 'subclass including module' do
    it 'instance parents should be [ subclass, class, Object, PP::ObjectMixin, Kernel, BasicObject ]' do
      parallel_ancestry.instance_parents( subclass_including_module ).should == [ subclass, module_to_include, class_instance, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
  end
  
end
