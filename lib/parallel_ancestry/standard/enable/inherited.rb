# -*- encoding : utf-8 -*-

module ::ParallelAncestry::Standard::Enable::Inherited

  ###############
  #  inherited  #
  ###############
  
  def inherited( subclass )
    
    super if defined?( super )

    ::ParallelAncestry::Standard.register_singleton_parent( subclass, self )
    ::ParallelAncestry::Standard.register_instance_parent( subclass, self )

  end
  
end
