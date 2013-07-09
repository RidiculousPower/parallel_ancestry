# -*- encoding : utf-8 -*-

module ::ParallelAncestry::Enable::Object

  ################
  #  initialize  #
  ################
  
  def initialize
    
    ::ParallelAncestry.register_singleton_parent( self, self.class )

    super if defined?( super )
    
  end
  
end
