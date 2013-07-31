# -*- encoding : utf-8 -*-

require 'call_super'
require 'array/unique/compositing'

module ::ParallelAncestry
  module Common
  end
end

[
  'common/parents',
  'common/children',
  'common/bootstrap',
  'common/register',
  'common/unregister'
].each { |this_file| require_relative( this_file << '.rb' ) }

module ::ParallelAncestry::Common

  include ::ParallelAncestry::Common::Register
  include ::ParallelAncestry::Common::Unregister
  include ::ParallelAncestry::Common::Children

  ###################
  #  self.extended  #
  ###################

  def self.extended( instance )
    
    instance.extend( ::ParallelAncestry::Common::Bootstrap,
                     ::ParallelAncestry::Common::Parents )
    
  end

end
