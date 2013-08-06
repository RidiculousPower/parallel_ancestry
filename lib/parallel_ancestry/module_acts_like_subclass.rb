# -*- encoding : utf-8 -*-

# Elements shared between ParallelAncestry::Standard and ParallelAncestry::ModuleActsLikeSubclass
require_relative 'common.rb'

module ::ParallelAncestry::ModuleActsLikeSubclass
  module Enable
    module IncludedExtended
    end
  end
  extend ::ParallelAncestry::Common
end

[
  'module_acts_like_subclass/register',
  'module_acts_like_subclass/unregister',
  'module_acts_like_subclass/enable/inherited'
].each { |this_file| require_relative( this_file << '.rb' ) }

module ::ParallelAncestry::ModuleActsLikeSubclass
  extend ::ParallelAncestry::ModuleActsLikeSubclass::Register
  extend ::ParallelAncestry::ModuleActsLikeSubclass::Unregister
end

class ::Object
  extend ::ParallelAncestry::ModuleActsLikeSubclass::Enable::Inherited
end

class ::Module
  include ::ParallelAncestry::ModuleActsLikeSubclass::Enable::IncludedExtended
end

[
  'module_acts_like_subclass/enable/included_extended'
].each { |this_file| require_relative( this_file << '.rb' ) }
