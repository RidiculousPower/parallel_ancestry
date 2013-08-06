
shared_examples_for 'ParallelAncestry Base' do

  initialize_base_test_setup

  context 'module' do
    it 'singleton parents should be [ module, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( module_instance ).should == [ module_instance, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'instance parents should be [ module ]' do
      parallel_ancestry.instance_parents( module_instance ).should == [ module_instance ]
    end
  end

  context 'class' do
    it 'instance parents should be [ class, Object, PP::ObjectMixin, Kernel, BasicObject ]' do
      parallel_ancestry.instance_parents( class_instance ).should == [ class_instance, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
  end
  
  context 'subclass' do
    it 'instance parents should be [ subclass, class, Object, PP::ObjectMixin, Kernel, BasicObject ]' do
      parallel_ancestry.instance_parents( subclass ).should == [ subclass, class_instance, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
  end
  
  context 'instance of object' do
    it 'singleton parents should be [ instance_of_object, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( instance_of_object ).should == [ instance_of_object, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
    it 'instance parents should be singleton parents' do
      parallel_ancestry.instance_parents( instance_of_object ).should be parallel_ancestry.parents( instance_of_object )
    end
  end
  
  context 'instance of class' do
    it 'singleton parents should be [ instance_of_class, class_instance, Object, PP::ObjectMixin, Kernel, BasicObject ]' do
      parallel_ancestry.parents( instance_of_class ).should == [ instance_of_class, class_instance, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
    it 'instance parents should be singleton parents' do
      parallel_ancestry.instance_parents( instance_of_class ).should be parallel_ancestry.parents( instance_of_class )
    end
  end
  
  context 'instance of subclass' do
    it 'singleton parents should be [ instance_of_class, subclass, class_instance, Object, PP::ObjectMixin, Kernel, BasicObject ]' do
      parallel_ancestry.parents( instance_of_subclass ).should == [ instance_of_subclass, subclass, class_instance, ::Object, ::PP::ObjectMixin, ::Kernel, ::BasicObject ]
    end
    it 'instance parents should be singleton parents' do
      parallel_ancestry.instance_parents( instance_of_subclass ).should be parallel_ancestry.parents( instance_of_subclass )
    end
  end
  
end