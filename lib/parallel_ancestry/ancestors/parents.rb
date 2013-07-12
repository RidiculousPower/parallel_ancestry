# -*- encoding : utf-8 -*-

module ::ParallelAncestry::SingletonParents

  #####################
  #  register_parent  #
  #####################
  
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
  def register_parent( child, parent, 
                       child_ancestry_struct = ancestry_struct( child ),
                       parent_ancestry_struct = ancestry_struct( parent ),
                       child_parents = parents( child, child_ancestry_struct ),
                       parent_children = children( parent, parent_ancestry_struct ) )

    # parent order determines who wins conflicts, so we keep youngest first
    child_parents.unshift( parent )

    # child order shouldn't be relevant
    parent_children.push( child )

    return self

  end


  #######################
  #  unregister_parent  #
  #######################
  
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
  def unregister_parent( child, parent, 
                         child_ancestry_struct = ancestry_struct( child ),
                         parent_ancestry_struct = ancestry_struct( parent ),
                         child_parents = parents( child, child_ancestry_struct ),
                         parent_children = children( parent, parent_ancestry_struct ) )

    child_parents.delete( child )
    parent_children.delete( parent )

    return self

  end

  ##################
  #  has_parents?  #
  ##################
  
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
  def has_parents?( instance, 
                    ancestry_struct = ancestry_struct( instance ),
                    parents = parents( instance, ancestry_struct ) )
    
    return ! parents.empty?

  end

  ##########################
  #  is_immediate_parent?  #
  ##########################
  
  def is_immediate_parent?( instance, potential_parent, 
                            ancestry_struct = ancestry_struct( instance ),
                            parents = parents( instance, ancestry_struct ) )
    
    return parents.include?( potential_parent )
    
  end

  ################
  #  is_parent?  #
  ################
  
  def is_parent?( instance, potential_parent, 
                  ancestry_struct = ancestry_struct( instance ),
                  parents = parents( instance, ancestry_struct ) )
    
    return is_immediate_parent?( instance, potential_parent, ancestry_struct, parents ) ||
           parents.any? { |this_parent| is_parent?( this_parent, potential_parent ) }
    
  end

  ####################
  #  lowest_parents  #
  ####################
  
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
  def lowest_parents( instance, 
                      ancestry_struct = ancestry_struct( instance ),
                      parents = parents( instance, ancestry_struct ),
                      & match_parent_block )

    lowest_parents_array = [ ]

    parents.each do |this_parent|
      # if we match this parent we are done with this branch and can go to the next
      if match_parent_block.call( this_parent )
        lowest_parents_array.push( this_parent )
      # otherwise our branch expands and we have to finish it before the next parent
      else
        parent_ancestry_struct = ancestry_struct( this_parent )
        this_parent_parents = parents( this_parent, parent_ancestry_struct )
        if has_parents?( this_parent, parent_ancestry_struct, this_parent_parents )
          parents_for_branch = lowest_parents( this_parent, 
                                               parent_ancestry_struct, 
                                               this_parent_parents, 
                                               & match_parent_block )
          lowest_parents_array.concat( parents_for_branch )
        end
      end
    end

    return lowest_parents_array
    
  end

end
