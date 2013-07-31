# -*- encoding : utf-8 -*-

module ::ParallelAncestry::IncludeActsLikeSubclass::Enable::Include

  #############
  #  include  #
  #############
  
  def include( *modules )
    
    super if defined?( super )
    
  end

end
