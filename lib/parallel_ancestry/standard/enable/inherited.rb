# -*- encoding : utf-8 -*-

module ::ParallelAncestry::Standard::Enable::Inherited

  ###############
  #  inherited  #
  ###############
  
  def inherited( subclass )

    ::ParallelAncestry::Standard.register_subclass( subclass, self )
    
    super if defined?( super )

  end
  
end
