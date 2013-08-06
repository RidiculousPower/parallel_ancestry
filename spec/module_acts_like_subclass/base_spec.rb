# -*- encoding : utf-8 -*-

require_relative '../../lib/parallel_ancestry/module_acts_like_subclass.rb'
require_relative '../setup.rb'
require_relative '../common/base_shared.rb'

describe 'ParallelAncestry::ModuleActsLikeSubclass Base' do
  
  initialize_base_test_setup
  it_behaves_like 'ParallelAncestry Base' do
    let( :parallel_ancestry ) { ::ParallelAncestry::ModuleActsLikeSubclass }
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
