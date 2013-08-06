
require_relative '../common/base_shared.rb'

shared_examples_for 'ParallelAncestry::Standard Base' do

  it_behaves_like 'ParallelAncestry Base' do
    context 'class' do
      it 'singleton parents should be [ class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.parents( class_instance ).should == [ class_instance, ::Class, ::Module, ::Object, ::Kernel, ::BasicObject ]
      end
    end
    context 'subclass' do
      it 'singleton parents should be [ subclass, class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.parents( subclass ).should == [ subclass, class_instance, ::Class, ::Module, ::Object, ::Kernel, ::BasicObject ]
      end
    end
  end

end
