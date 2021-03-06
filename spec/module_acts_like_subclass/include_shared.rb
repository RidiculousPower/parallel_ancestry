# -*- encoding : utf-8 -*-

require_relative '../common/include_shared.rb'

shared_examples_for 'ParallelAncestry::ModuleActsLikeSubclass Include' do

  it_behaves_like 'ParallelAncestry Include' do
    let( :parallel_ancestry ) { ::ParallelAncestry::ModuleActsLikeSubclass }
    it 'singleton parents should be [ module, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( module_including_module ).should == [ module_instance, module_to_include, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'singleton parents should be [ class, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( class_including_module ).should == [ class_instance, module_to_include, ::Class, ::PP::ObjectMixin, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'singleton parents should be [ subclass, class, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( subclass_including_module ).should == [ subclass, module_to_include, class_instance, ::Class, ::PP::ObjectMixin, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
  end

end
