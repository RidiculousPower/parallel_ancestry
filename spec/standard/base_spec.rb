# -*- encoding : utf-8 -*-

require_relative '../../lib/parallel_ancestry/standard.rb'
require_relative '../setup.rb'
require_relative '../common/base_shared.rb'

describe 'ParallelAncestry::Standard Base' do
  
  it_behaves_like 'ParallelAncestry Base' do
    let( :parallel_ancestry ) { ::ParallelAncestry::Standard }    
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
