# -*- encoding : utf-8 -*-

require_relative '../lib/parallel_ancestry/standard.rb'
require_relative '../lib/parallel_ancestry/module_acts_like_subclass.rb'

require_relative 'standard/base_shared.rb'
require_relative 'standard/extend_shared.rb'
require_relative 'standard/include_shared.rb'

require_relative 'module_acts_like_subclass/base_shared.rb'
require_relative 'module_acts_like_subclass/extend_shared.rb'
require_relative 'module_acts_like_subclass/include_shared.rb'

describe 'ParallelAncestry::Standard and ParallelAncestry::ModuleActsLikeSubclass simultaneously' do
  
  it_behaves_like 'ParallelAncestry::Standard Base' do
    let( :parallel_ancestry ) { ::ParallelAncestry::Standard }
  end
  it_behaves_like 'ParallelAncestry::Standard Include' do
    let( :parallel_ancestry ) { ::ParallelAncestry::Standard }
  end
  it_behaves_like 'ParallelAncestry::Standard Extend' do
    let( :parallel_ancestry ) { ::ParallelAncestry::Standard }
  end

  it_behaves_like 'ParallelAncestry::ModuleActsLikeSubclass Base' do
    let( :parallel_ancestry ) { ::ParallelAncestry::ModuleActsLikeSubclass }
  end
  it_behaves_like 'ParallelAncestry::ModuleActsLikeSubclass Include' do
    let( :parallel_ancestry ) { ::ParallelAncestry::ModuleActsLikeSubclass }
  end
  it_behaves_like 'ParallelAncestry::ModuleActsLikeSubclass Extend' do
    let( :parallel_ancestry ) { ::ParallelAncestry::ModuleActsLikeSubclass }
  end
    
end
