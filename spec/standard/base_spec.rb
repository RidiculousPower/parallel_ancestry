# -*- encoding : utf-8 -*-

require_relative '../../lib/parallel_ancestry/standard.rb'
require_relative '../setup.rb'
require_relative 'base_shared.rb'

describe 'ParallelAncestry::Standard Base' do
  
  it_behaves_like 'ParallelAncestry::Standard Base' do
    let( :parallel_ancestry ) { ::ParallelAncestry::Standard }    
  end

end
