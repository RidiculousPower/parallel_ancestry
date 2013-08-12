# -*- encoding : utf-8 -*-

module ::ParallelAncestry::Inherited

  ###############
  #  inherited  #
  ###############
  
  def inherited( subclass )

    ::ParallelAncestry.register_subclass( subclass, self )
    
    super if defined?( super )

  end
  
end

