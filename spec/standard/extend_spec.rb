# -*- encoding : utf-8 -*-

require_relative 'extend_shared.rb'

describe 'ParallelAncestry::Standard Extend' do
  
  it_behaves_like 'ParallelAncestry::Standard Extend' do
    let( :parallel_ancestry ) { ::ParallelAncestry::Standard }    
  end
  
end

