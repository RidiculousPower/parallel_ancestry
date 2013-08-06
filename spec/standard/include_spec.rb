# -*- encoding : utf-8 -*-

require_relative 'include_shared.rb'

describe 'ParallelAncestry::Standard Include' do

  it_behaves_like 'ParallelAncestry::Standard Include' do
    let( :parallel_ancestry ) { ::ParallelAncestry::Standard }    
  end
  
end
