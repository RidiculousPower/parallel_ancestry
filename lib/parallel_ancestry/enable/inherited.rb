# -*- encoding : utf-8 -*-

module ::ParallelAncestry::Enable::Inherited

  ###############
  #  inherited  #
  ###############
  
  def inherited( subclass )
    
    super if defined?( super )

    ::ParallelAncestry.register_singleton_parent( subclass, self )
    ::ParallelAncestry.register_instance_parent( subclass, self )

  end
  
end
