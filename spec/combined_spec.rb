module ::ParallelAncestry
end

module ::ParallelAncestry::SpecFix
  def append_features( hooked_instance )
    super unless equal?( ::ParallelAncestry::Standard::Enable::Inherited )                      ||
                 equal?( ::ParallelAncestry::ModuleActsLikeSubclass::Enable::Inherited )        ||
                 equal?( ::ParallelAncestry::Standard::Enable::IncludedExtended )               ||
                 equal?( ::ParallelAncestry::ModuleActsLikeSubclass::Enable::IncludedExtended ) ||
                 ( ! defined?( super ) )
  end
  def extend_object( hooked_instance )
    super unless equal?( ::ParallelAncestry::Standard::Enable::Inherited )                      ||
                 equal?( ::ParallelAncestry::ModuleActsLikeSubclass::Enable::Inherited )        ||
                 equal?( ::ParallelAncestry::Standard::Enable::IncludedExtended )               ||
                 equal?( ::ParallelAncestry::ModuleActsLikeSubclass::Enable::IncludedExtended ) ||
                 ( ! defined?( super ) )
  end  
end

module ::ParallelAncestry
  const_set( :Standard, self )
  module Standard
    module Enable
      module Inherited
      end
      module IncludedExtended
      end
    end
  end
  module ModuleActsLikeSubclass
    module Enable
      module Inherited
      end
      module IncludedExtended
      end
    end
  end
end

class ::Object
  extend ::ParallelAncestry::Standard::Enable::Inherited
  extend ::ParallelAncestry::ModuleActsLikeSubclass::Enable::Inherited
end

class ::Module
  include ::ParallelAncestry::Standard::Enable::IncludedExtended
  include ::ParallelAncestry::ModuleActsLikeSubclass::Enable::IncludedExtended
  include ::ParallelAncestry::SpecFix
end

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
