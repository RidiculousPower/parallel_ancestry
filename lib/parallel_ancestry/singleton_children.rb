# -*- encoding : utf-8 -*-

module ::ParallelAncestry::SingletonChildren

  ########################
  #  singleton_children  #
  ########################
  
  ###
  # Return a list of children for provided object.
  #
  # @param [Object] instance 
  #
  #        Object instance.
  #
  # @return [Array<Object>] An array containing references to immediate children for any configuration.
  #
  def singleton_children( instance, 
                          ancestry_struct = ancestry_struct( instance ) )
    
    return ancestry_struct.singleton_children ||= ::ParallelAncestry::Array::UniqueByID.new( self )

  end

  ##############################
  #  register_singleton_child  #
  ##############################
  
  ###
  # Register instance as parent of another instance.
  #
  # @param [Object] parent 
  #
  #        Child instance.
  #
  # @param [Object] child 
  #
  #        Parent instance.
  #
  # @return Self.
  #
  def register_singleton_child( parent, child, 
                                parent_ancestry_struct = ancestry_struct( parent ),
                                child_ancestry_struct = ancestry_struct( child ),
                                parent_singleton_children = singleton_children( parent, parent_ancestry_struct ),
                                child_singleton_parents = singleton_parents( child, child_ancestry_struct ) )
    
    # parent order determines who wins conflicts, so we keep youngest first
    child_singleton_parents.unshift( parent )

    # child order shouldn't be relevant
    parent_singleton_children.push( child )

    return self

  end


  ################################
  #  unregister_singleton_child  #
  ################################
  
  ###
  # Unregister instance as parent of another instance.
  #
  # @param [Object] parent 
  #
  #        Child instance.
  #
  # @param [Object] child 
  #
  #        Parent instance.
  #
  # @return Self.
  #
  def unregister_singleton_child( parent, child, 
                                  parent_ancestry_struct = ancestry_struct( parent ),
                                  child_ancestry_struct = ancestry_struct( child ),
                                  parent_singleton_children = singleton_children( parent, parent_ancestry_struct ),
                                  child_singleton_parents = singleton_parents( child, child_ancestry_struct ) )

    parent_singleton_children.delete( parent )
    child_singleton_children.delete( child )

    return self

  end

  #############################
  #  has_singleton_children?  #
  #############################
  
  ###
  # Return whether provided object has children.
  #
  # @param [Object] instance 
  #
  #        Object instance.
  #
  # @return [true, false] 
  #
  #         true or false.
  #
  def has_singleton_children?( instance, 
                               ancestry_struct = ancestry_struct( instance ),
                               singleton_children = singleton_children( instance, ancestry_struct ) )
    
    return ! singleton_children.empty?

  end

  ###################################
  #  is_immediate_singleton_child?  #
  ###################################
  
  def is_immediate_singleton_child?( instance, potential_child, 
                                     ancestry_struct = ancestry_struct( instance ),
                                     singleton_children = singleton_children( instance, ancestry_struct ) )
    
    return singleton_children.include?( potential_child )
    
  end

  #########################
  #  is_singleton_child?  #
  #########################
  
  def is_singleton_child?( instance, potential_child, 
                           ancestry_struct = ancestry_struct( instance ),
                           singleton_children = singleton_children( instance, ancestry_struct ) )
    
    return singleton_children.include?( potential_child ) ||
           singleton_children.any? { |this_child| is_singleton_child?( this_child, potential_child ) }
    
  end

  ################################
  #  highest_singleton_children  #
  ################################
  
  ###
  # Returns the highest child in each child tree matching block condition. For simple linear
  # trees, this is simply the first child, but more complex trees quickly diverge into multiple
  # branches, each of which then requires a highest match.
  #
  # @param [Object] instance 
  #
  #        Instance for which children are being looked up.
  #
  # @yield 
  #
  #        Block used to match child. The parameter is the child instance, the return value true
  #        or false, reflecting whether or not block matched ancestor.
  #
  # @example
  #
  #   ::ParallelAncestry.highest_children( some_instance ) do |this_child|
  #     matches_arbitrary_condition? ? true : false
  #   end
  #
  # @return [Array<Object>] 
  #
  #         An array containing references to highest child in each child tree 
  #         matching block condition.
  #
  def highest_singleton_children( instance, 
                                  ancestry_struct = ancestry_struct( instance ),
                                  singleton_children = singleton_children( instance, ancestry_struct ),
                                  & match_child_block )

    highest_singleton_children_array = [ ]

    singleton_children.each do |this_child|
      # if we match this child we are done with this branch and can go to the next
      if match_child_block.call( this_child )
        highest_singleton_children_array.push( this_child )
      # otherwise our branch expands and we have to finish it before the next child
      else
        child_ancestry_struct = ancestry_struct( this_child )
        this_child_singleton_children = singleton_children( this_child, child_ancestry_struct )
        if has_singleton_children?( this_child, child_ancestry_struct, this_child_singleton_children )
          children_for_branch = highest_singleton_children( this_child, 
                                                            child_ancestry_struct, 
                                                            this_child_singleton_children, 
                                                            & match_child_block )
          highest_singleton_children_array.concat( children_for_branch )
        end
      end
    end

    return highest_singleton_children_array
    
  end

end
