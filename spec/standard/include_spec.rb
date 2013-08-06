# -*- encoding : utf-8 -*-

require_relative '../../lib/parallel_ancestry/standard.rb'
require_relative '../setup.rb'
require_relative '../common/include_shared.rb'

describe 'ParallelAncestry::Standard Include' do

  initialize_base_test_setup

  it_behaves_like 'ParallelAncestry Include' do
    let( :parallel_ancestry ) { ::ParallelAncestry::Standard }
    it 'singleton parents should be [ module, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( module_including_module ).should == [ module_instance, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'singleton parents should be [ class, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( class_including_module ).should == [ class_instance, ::Class, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'singleton parents should be [ subclass, class, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( subclass_including_module ).should == [ subclass, class_instance, ::Class, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
  end
  
end
