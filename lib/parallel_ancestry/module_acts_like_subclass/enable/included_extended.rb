# -*- encoding : utf-8 -*-

module ::ParallelAncestry::ModuleActsLikeSubclass::Enable::IncludedExtended

  #####################
  #  append_features  #
  #####################

  ###
  # Register instance parent.
  #
  # @param [Module,Class] hooked_instance
  #
  #        Instance being registered as child.
  #
  def append_features( hooked_instance )

    ::ParallelAncestry::ModuleActsLikeSubclass.register_include( hooked_instance, self )

    super if defined?( super )
    
  end

  ###################
  #  extend_object  #
  ###################

  ###
  # Register singleton parent.
  #
  # @param [Module,Class] hooked_instance
  #
  #        Instance being registered as child.
  #
  def extend_object( hooked_instance )
    
    # we don't want to treat self as a parent for modules that extend themselves
    unless hooked_instance.equal?( self )
      ::ParallelAncestry::ModuleActsLikeSubclass.register_extend( hooked_instance, self )
    end
    
    super if defined?( super )
    
  end
  
end
