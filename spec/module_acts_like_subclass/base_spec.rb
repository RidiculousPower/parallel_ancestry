# -*- encoding : utf-8 -*-

require_relative '../../lib/parallel_ancestry/module_acts_like_subclass.rb'
require_relative '../setup.rb'
require_relative 'base_shared.rb'

describe 'ParallelAncestry::ModuleActsLikeSubclass Base' do
  
  it_behaves_like 'ParallelAncestry::ModuleActsLikeSubclass Base' do
    let( :parallel_ancestry ) { ::ParallelAncestry::ModuleActsLikeSubclass }
  end
  
end
