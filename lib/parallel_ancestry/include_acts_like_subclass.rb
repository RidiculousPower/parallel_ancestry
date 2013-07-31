# -*- encoding : utf-8 -*-

# Elements shared between ParallelAncestry::Standard and ParallelAncestry::IncludeActsLikeSubclass
require_relative 'common.rb'

module ::ParallelAncestry::IncludeActsLikeSubclass
  module Enable
  end
  extend ::ParallelAncestry::Common
end

[
  'include_acts_like_subclass/register',
  'include_acts_like_subclass/unregister',
  'include_acts_like_subclass/enable/included_extended',
  'include_acts_like_subclass/enable/inherited'
].each { |this_file| require_relative( this_file << '.rb' ) }

module ::ParallelAncestry::IncludeActsLikeSubclass
  extend ::ParallelAncestry::IncludeActsLikeSubclass::Register
  extend ::ParallelAncestry::IncludeActsLikeSubclass::Unregister
end

class ::Object
  extend ::ParallelAncestry::IncludeActsLikeSubclass::Enable::Inherited
end

class ::Module
  include ::ParallelAncestry::IncludeActsLikeSubclass::Enable::IncludedExtended
end
