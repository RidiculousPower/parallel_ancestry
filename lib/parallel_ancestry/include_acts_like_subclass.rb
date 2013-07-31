# -*- encoding : utf-8 -*-

# Elements shared between ParallelAncestry::Standard and ParallelAncestry::IncludeActsLikeSubclass
require_relative 'common.rb'

module ::ParallelAncestry::IncludeActsLikeSubclass
  module Enable
  end
  extend ::ParallelAncestry::Common
end

[
  'include_acts_like_subclass/enable/include_acts_like_subclass'
].each { |this_file| require_relative( this_file << '.rb' ) }

#class ::Module
#  include ::ParallelAncestry::IncludeActsLikeSubclass::Enable::Module
#end
#
#class ::Object
#  extend ::ParallelAncestry::IncludeActsLikeSubclass::Enable::Object
#end
