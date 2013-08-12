# -*- encoding : utf-8 -*-

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

