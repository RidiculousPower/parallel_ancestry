# -*- encoding : utf-8 -*-

module ::ParallelAncestry::SingletonParents

  #######################
  #  singleton_parents  #
  #######################
  
  ###
  # Return a list of parents for provided object.
  #
  # @param [Object] instance 
  #
  #        Object instance.
  #
  # @return [Array<Object>] An array containing references to immediate parents for any configuration.
  #
  def singleton_parents( instance, 
                         ancestry_struct = ancestry_struct( instance ) )
    
    return ancestry_struct.singleton_parents ||= ::ParallelAncestry::Array::UniqueByID.new( self )

  end

  ###############################
  #  register_singleton_parent  #
  ###############################
  
  ###
  # Register instance as child of another instance.
  #
  # @param [Object] child 
  #
  #        Child instance.
  #
  # @param [Object] parent 
  #
  #        Parent instance.
  #
  # @return Self.
  #
  def register_singleton_parent( child, parent, 
                                 child_ancestry_struct = ancestry_struct( child ),
                                 parent_ancestry_struct = ancestry_struct( parent ),
                                 child_singleton_parents = singleton_parents( child, child_ancestry_struct ),
                                 parent_singleton_children = singleton_children( parent, parent_ancestry_struct ) )
    
    # parent order determines who wins conflicts, so we keep youngest first
    child_singleton_parents.unshift( parent )

    # child order shouldn't be relevant
    parent_singleton_children.push( child )

    return self

  end


  #################################
  #  unregister_singleton_parent  #
  #################################
  
  ###
  # Unregister instance as child of another instance.
  #
  # @param [Object] child 
  #
  #        Child instance.
  #
  # @param [Object] parent 
  #
  #        Parent instance.
  #
  # @return Self.
  #
  def unregister_singleton_parent( child, parent, 
                                   child_ancestry_struct = ancestry_struct( child ),
                                   parent_ancestry_struct = ancestry_struct( parent ),
                                   child_singleton_parents = singleton_parents( child, child_ancestry_struct ),
                                   parent_singleton_children = singleton_children( parent, parent_ancestry_struct ) )

    child_singleton_parents.delete( child )
    parent_singleton_children.delete( parent )

    return self

  end

  ############################
  #  has_singleton_parents?  #
  ############################
  
  ###
  # Return whether provided object has parents.
  #
  # @param [Object] instance 
  #
  #        Object instance.
  #
  # @return [true, false] 
  #
  #         true or false.
  #
  def has_singleton_parents?( instance, 
                              ancestry_struct = ancestry_struct( instance ),
                              singleton_parents = singleton_parents( instance, ancestry_struct ) )
    
    return ! singleton_parents.empty?

  end

  ####################################
  #  is_immediate_singleton_parent?  #
  ####################################
  
  def is_immediate_singleton_parent?( instance, potential_parent, 
                                      ancestry_struct = ancestry_struct( instance ),
                                      singleton_parents = singleton_parents( instance, ancestry_struct ) )
    
    return singleton_parents.include?( potential_parent )
    
  end

  ##########################
  #  is_singleton_parent?  #
  ##########################
  
  def is_singleton_parent?( instance, potential_parent, 
                            ancestry_struct = ancestry_struct( instance ),
                            singleton_parents = singleton_parents( instance, ancestry_struct ) )
    
    return singleton_parents.include?( potential_parent ) ||
           singleton_parents.any? { |this_parent| is_singleton_parent?( this_parent, potential_parent ) }
    
  end

  ##############################
  #  lowest_singleton_parents  #
  ##############################
  
  ###
  # Returns the lowest parent in each parent tree matching block condition. For simple linear
  # trees, this is simply the first parent, but more complex trees quickly diverge into multiple
  # branches, each of which then requires a lowest match.
  #
  # @param [Object] instance 
  #
  #        Instance for which parents are being looked up.
  #
  # @yield 
  #
  #        Block used to match parent. The parameter is the parent instance, the return value true
  #        or false, reflecting whether or not block matched ancestor.
  #
  # @example
  #
  #   ::ParallelAncestry.lowest_parents( some_instance ) do |this_parent|
  #     matches_arbitrary_condition? ? true : false
  #   end
  #
  # @return [Array<Object>] 
  #
  #         An array containing references to lowest parent in each parent tree 
  #         matching block condition.
  #
  def lowest_singleton_parents( instance, 
                                ancestry_struct = ancestry_struct( instance ),
                                singleton_parents = singleton_parents( instance, ancestry_struct ),
                                & match_parent_block )

    lowest_singleton_parents_array = [ ]

    singleton_parents.each do |this_parent|
      # if we match this parent we are done with this branch and can go to the next
      if match_parent_block.call( this_parent )
        lowest_singleton_parents_array.push( this_parent )
      # otherwise our branch expands and we have to finish it before the next parent
      else
        parent_ancestry_struct = ancestry_struct( this_parent )
        this_parent_singleton_parents = singleton_parents( this_parent, parent_ancestry_struct )
        if has_singleton_parents?( this_parent, parent_ancestry_struct, this_parent_singleton_parents )
          parents_for_branch = lowest_singleton_parents( this_parent, 
                                                         parent_ancestry_struct, 
                                                         this_parent_singleton_parents, 
                                                         & match_parent_block )
          lowest_singleton_parents_array.concat( parents_for_branch )
        end
      end
    end

    return lowest_singleton_parents_array
    
  end

end