# -*- encoding : utf-8 -*-

module ::ParallelAncestry::ModuleSubclassInitialization

  ################
  #  initialize  #
  ################
  
  # define with *args so we can be inserted anywhere in inheritance chain
  def initialize( *args )
    
    # call super if defined so we can be inserted anywhere in inheritance chain
    super if defined?( super )

    @ancestors_hash = { }

  end

end
