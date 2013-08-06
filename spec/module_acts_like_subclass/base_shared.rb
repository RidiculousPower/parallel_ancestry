
require_relative '../common/base_shared.rb'

shared_examples_for 'ParallelAncestry::ModuleActsLikeSubclass Base' do

  it_behaves_like 'ParallelAncestry Base' do
    context 'class' do
      it 'singleton parents should be [ class, PP::ObjectMixin, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.parents( class_instance ).should == [ class_instance, ::Class, ::PP::ObjectMixin, ::Module, ::Object, ::Kernel, ::BasicObject ]
      end
    end
    context 'subclass' do
      it 'singleton parents should be [ subclass, class, PP::ObjectMixin, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.parents( subclass ).should == [ subclass, class_instance, ::Class, ::PP::ObjectMixin, ::Module, ::Object, ::Kernel, ::BasicObject ]
      end
    end
  end

end
