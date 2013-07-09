# -*- encoding : utf-8 -*-

module ::ParallelAncestry::InstanceChildren

  #######################
  #  instance_children  #
  #######################
  
  ###
  # Return a list of children for provided object.
  #
  # @param [Object] instance 
  #
  #        Object instance.
  #
  # @return [Array<Object>] An array containing references to immediate children for any configuration.
  #
  def instance_children( instance, 
                         ancestry_struct = ancestry_struct( instance ) )
    
    return ancestry_struct.instance_children ||= ::ParallelAncestry::Array::UniqueByID.new( self )

  end

  #############################
  #  register_instance_child  #
  #############################
  
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
  def register_instance_child( parent, child, 
                               parent_ancestry_struct = ancestry_struct( parent ),
                               child_ancestry_struct = ancestry_struct( child ),
                               parent_instance_children = instance_children( parent, parent_ancestry_struct ),
                               child_instance_parents = instance_parents( child, child_ancestry_struct ) )
    
    # parent order determines who wins conflicts, so we keep youngest first
    child_instance_parents.unshift( parent )

    # child order shouldn't be relevant
    parent_instance_children.push( child )

    return self

  end


  ###############################
  #  unregister_instance_child  #
  ###############################
  
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
  def unregister_instance_child( parent, child, 
                                 parent_ancestry_struct = ancestry_struct( parent ),
                                 child_ancestry_struct = ancestry_struct( child ),
                                 parent_instance_children = instance_children( parent, parent_ancestry_struct ),
                                 child_instance_parents = instance_parents( child, child_ancestry_struct ) )

    parent_instance_children.delete( parent )
    child_instance_children.delete( child )

    return self

  end

  ############################
  #  has_instance_children?  #
  ############################
  
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
  def has_instance_children?( instance, 
                              ancestry_struct = ancestry_struct( instance ),
                              instance_children = instance_children( instance, ancestry_struct ) )
    
    return ! instance_children.empty?

  end

  ##################################
  #  is_immediate_instance_child?  #
  ##################################
  
  def is_immediate_instance_child?( instance, potential_child, 
                                    ancestry_struct = ancestry_struct( potential_child ),
                                    potential_child_parents = instance_parents( potential_child, ancestry_struct ) )
    
    return case potential_child
      when ::Module
        potential_child_parents.include?( instance )
      else
        potential_child_parents.empty? ? instance.equal?( potential_child.class )
                                       : potential_child_parents.include?( instance )
    end
    
  end

  ########################
  #  is_instance_child?  #
  ########################
  
  def is_instance_child?( instance, potential_child, 
                          ancestry_struct = ancestry_struct( potential_child ),
                          potential_child_parents = instance_parents( potential_child, ancestry_struct ) )

    return is_immediate_instance_child?( instance, potential_child, ancestry_struct, potential_child_parents ) ||
           potential_child_parents.any? { |this_child| is_instance_child?( this_child, potential_child ) }
    
  end

  ###############################
  #  highest_instance_children  #
  ###############################
  
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
  def highest_instance_children( instance, 
                                 ancestry_struct = ancestry_struct( instance ),
                                 instance_children = instance_children( instance, ancestry_struct ),
                                 & match_child_block )

    highest_instance_children_array = [ ]

    instance_children.each do |this_child|
      # if we match this child we are done with this branch and can go to the next
      if match_child_block.call( this_child )
        highest_instance_children_array.push( this_child )
      # otherwise our branch expands and we have to finish it before the next child
      else
        child_ancestry_struct = ancestry_struct( this_child )
        this_child_instance_children = instance_children( this_child, child_ancestry_struct )
        if has_instance_children?( this_child, child_ancestry_struct, this_child_instance_children )
          children_for_branch = highest_instance_children( this_child, 
                                                          child_ancestry_struct, 
                                                          this_child_instance_children, 
                                                          & match_child_block )
          highest_instance_children_array.concat( children_for_branch )
        end
      end
    end

    return highest_instance_children_array
    
  end
  
end
