# -*- encoding : utf-8 -*-

module ::ParallelAncestry::Enable::Object

  extend ::PreAndPostInitialize

  ####################
  #  self.inherited  #
  ####################
  
  def self.inherited( subclass )
    
    super if defined?( super )
    
    ::ParallelAncestry.register_singleton_parent( self, self.class )

  end
  
  ####################
  #  pre_initialize  #
  ####################

  def pre_initialize( *args, & block )

    super

    ::ParallelAncestry.register_instance_parent( self, self.class )
    
  end

end
