# -*- encoding : utf-8 -*-

require_relative '../../lib/parallel_ancestry.rb'

describe 'ParallelAncestry common bootstrapping' do
  
  let( :parallel_ancestry ) { ::ParallelAncestry::Common.extend( ::ParallelAncestry::Common ) }
  
  context 'BasicObject bootstrapping' do
    it 'is bootstrapped for singleton parents that inherit from Class instance parents: [ Class, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( ::BasicObject ).should == [ ::Class, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'is bootstrapped for instance parents [ BasicObject ]' do
      parallel_ancestry.instance_parents( ::BasicObject ).should == [ ::BasicObject ]
    end
  end

  context 'Kernel bootstrapping' do
    it 'is bootstrapped for singleton parents that inherit from Module instance parents: [ Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( ::Kernel ).should == [ ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'is bootstrapped for instance parents [ Kernel ]' do
      parallel_ancestry.instance_parents( ::Kernel ).should == [ ::Kernel ]
    end
  end

  context 'Object bootstrapping' do
    it 'is bootstrapped for singleton parents that inherit from Class instance parents: [ Class, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( ::Object ).should == [ ::Class, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'is bootstrapped for instance parents [ Object, Kernel, BasicObject ]' do
      parallel_ancestry.instance_parents( ::Object ).should == [ ::Object, ::Kernel, ::BasicObject ]
    end
  end

  context 'Class bootstrapping' do
    it 'is bootstrapped for singleton parents that inherit from Class instance parents: [ Class, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( ::Class ).should == [ ::Class, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'is bootstrapped for instance parents [ Class, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.instance_parents( ::Class ).should == [ ::Class, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
  end

  context 'Module bootstrapping' do
    it 'is bootstrapped for singleton parents that inherit from Class instance parents: [ Class, Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.parents( ::Module ).should == [ ::Class, ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
    it 'is bootstrapped for instance parents [ Module, Object, Kernel, BasicObject ]' do
      parallel_ancestry.instance_parents( ::Module ).should == [ ::Module, ::Object, ::Kernel, ::BasicObject ]
    end
  end

end

