# -*- encoding : utf-8 -*-

module ::ParallelAncestry::IncludeActsLikeSubclass::Enable::Inherited

  ###############
  #  inherited  #
  ###############
  
  def inherited( subclass )
    
    super if defined?( super )

    ::ParallelAncestry::IncludeActsLikeSubclass.register_parent( subclass, self )
    ::ParallelAncestry::IncludeActsLikeSubclass.register_instance_parent( subclass, self )

  end
  
end
