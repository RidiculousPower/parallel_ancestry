# -*- encoding : utf-8 -*-

# Elements shared between ParallelAncestry::Standard and ParallelAncestry::IncludeActsLikeSubclass
require_relative 'common.rb'

::ParallelAncestry.const_set( :Standard, ::ParallelAncestry ) unless ::ParallelAncestry.const_defined?( :Standard )

module ::ParallelAncestry::Standard
  module Enable
  end
  extend ::ParallelAncestry::Common
end

[
  'standard/enable/extend',
  'standard/enable/include',
  'standard/enable/included_extended',
  'standard/enable/inherited'
].each { |this_file| require_relative( this_file << '.rb' ) }

#class ::Module
#  include ::ParallelAncestry::Standard::Enable::Module
#end
#
#class ::Object
#  extend ::ParallelAncestry::Standard::Enable::Object
#end
