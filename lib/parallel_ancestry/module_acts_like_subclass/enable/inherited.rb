# -*- encoding : utf-8 -*-

module ::ParallelAncestry::ModuleActsLikeSubclass::Enable::Inherited

  ###############
  #  inherited  #
  ###############
  
  def inherited( subclass )
    
    super if defined?( super )

    ::ParallelAncestry::ModuleActsLikeSubclass.register_parent( subclass, self )
    ::ParallelAncestry::ModuleActsLikeSubclass.register_instance_parent( subclass, self )

  end
  
end
