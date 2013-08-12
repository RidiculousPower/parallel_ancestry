# -*- encoding : utf-8 -*-

require_relative '../../lib/parallel_ancestry/module_acts_like_subclass.rb'
require_relative '../setup.rb'
require_relative 'extend_shared.rb'

describe 'ParallelAncestry::ModuleActsLikeSubclass Extend' do

  it_behaves_like 'ParallelAncestry::ModuleActsLikeSubclass Extend' do
    let( :parallel_ancestry ) { ::ParallelAncestry::ModuleActsLikeSubclass }
  end

end

