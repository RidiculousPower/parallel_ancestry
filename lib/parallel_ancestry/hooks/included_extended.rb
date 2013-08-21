# -*- encoding : utf-8 -*-

module ::ParallelAncestry::Hooks::IncludedExtended

  #####################
  #  append_features  #
  #####################

  ###
  # Register include.
  #
  # @param [Module,Class] hooked_instance
  #
  #        Instance being registered as child.
  #
  def append_features( hooked_instance )

    ::ParallelAncestry.register_include( hooked_instance, self )

    super if defined?( super )
    
  end

  ###################
  #  extend_object  #
  ###################

  ###
  # Register extend.
  #
  # @param [Module,Class] hooked_instance
  #
  #        Instance being registered as child.
  #
  def extend_object( hooked_instance )
    
    # we don't want to treat self as a parent for modules that extend themselves
    unless hooked_instance.equal?( self )
      ::ParallelAncestry.register_extend( hooked_instance, self )
    end
    
    super if defined?( super )
    
  end
  
end

