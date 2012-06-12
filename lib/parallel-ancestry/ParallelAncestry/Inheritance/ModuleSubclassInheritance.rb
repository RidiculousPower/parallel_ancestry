
module ::ParallelAncestry::Inheritance::ModuleSubclassInheritance

  ################
  #  initialize  #
  ################
  
  # define with *args so we can be inserted anywhere in inheritance chain
  def initialize( *args )
    
    # call super if defined so we can be inserted anywhere in inheritance chain
    super if defined?( super )
    
    initialize_inheritance_for_module!
    
  end

end
