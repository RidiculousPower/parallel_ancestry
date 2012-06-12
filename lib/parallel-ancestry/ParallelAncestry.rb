
module ::ParallelAncestry

  InstanceAncestryStruct = ::Struct.new( :children_hash, :parents_array, :parents_hash )

  extend ::ModuleCluster::Define::Block::ClassOrModule
  
  # Initialize any module extended with self for inheritance hooks
  module_extend do |ancestors_module|    
    ancestors_module.module_eval do
      @ancestors_hash = { }
    end
  end
  
  # Initialize any subclass of module including self for inheritance hooks
  class_include do |class_instance|
    if class_instance < ::Module
      class_instance.module_eval do
        include( ::ParallelAncestry::ModuleSubclassInheritance )
      end
    end
  end
  
  extend self
  
  ##############
  #  children  #
  ##############
  
  # Return a list of children for provided object.
  # @param [Object] instance Object instance.
  # @return [Array<Object>] An array containing references to children.
  def children( instance )
    
    return children_hash( instance ).keys

  end

  #############
  #  parents  #
  #############
  
  # Return a list of parents for provided object.
  # @param [Object] instance Object instance.
  # @return [Array<Object>] An array containing references to immediate parents for any configuration.
  def parents( instance )
    
    return parents_array( instance )

  end

  ##################
  #  has_parents?  #
  ##################
  
  # Return whether provided object has parents.
  # @param [Object] instance Object instance.
  # @return [true, false] true or false.
  def has_parents?( instance )
    
    has_parents = false
    
    ancestor_struct = ancestor_struct( instance )
    
    if ancestor_struct.parents_array
      has_parents = ! ancestor_struct.parents_array.empty?
    end
    
    return has_parents

  end

  ###################
  #  has_children?  #
  ###################
  
  # Return whether provided object has children.
  # @param [Object] instance Object instance.
  # @return [true, false] true or false.
  def has_children?( instance )
    
    has_children = false
    
    ancestor_struct = ancestor_struct( instance )
    
    if ancestor_struct.children_hash
      has_children = ! ancestor_struct.children_hash.empty?
    end
    
    return has_children

  end

  ###############################
  #  register_child_for_parent  #
  ###############################
  
  # Register instance as child of another instance.
  # @param [Object] child Child instance.
  # @param [Object] parent Parent instance.
  # @return [Array<Object>] An array containing references to children.
  def register_child_for_parent( child, parent )

    parents_of_child_hash = parents_hash( child )
    children_of_parent_hash = children_hash( parent )

    unless children_of_parent_hash.has_key?( child )
      # child order shouldn't be relevant
      children_of_parent_hash[ child ] = true
    end
    
    unless parents_of_child_hash.has_key?( parent )
      parents_of_child_hash[ parent ] = true
      # parent order determines who wins conflicts, so we keep youngest first
      parents_array( child ).unshift( parent )
    end

    return self

  end

  ##############
  #  ancestor  #
  ##############
  
  # Return parent for instance that matches match_ancestor_block.
  # @param [Object] instance Child instance.
  # @yield Block used to match parent. The parameter is the parent instance, the return value true
  #        or false, reflecting whether or not block matched ancestor.
  # @example
  #   ::ParallelAncestry.ancestor( some_instance ) do |this_parent|
  #     if this_parent.matches_arbitrary_condition
  #       true
  #     else
  #       false
  #     end
  #   end
  # @return [Object] A reference to parent matching block condition.
  def ancestor( instance, & match_ancestor_block )
    
    ancestor_instance = nil
    
    parents = parents( instance )
    
    # If we don't have ancestors explicitly declared for this instance, and if it is not 
    # a ::Class or ::Module (both are ::Modules) then we have an instance of a class,
    # so we can use the instance's class
    if parents.empty? and ! instance.is_a?( ::Module )
      
      ancestor_instance = instance.class
            
    else

      parents.each do |this_parent|
        # we need a way to go from multiple parents to the one that makes up this chain
        # we use the match_ancestor_block to determine this - it should return true/false
        if match_ancestor_block.call( this_parent )
          ancestor_instance = this_parent
          break
        end
      end

    end
    
    return ancestor_instance
    
  end
  
  alias_method :parent, :ancestor
  
  ####################
  #  ancestor_chain  #
  ####################
  
  # Returns ancestor chain defined for provided object.
  # @param [Object] instance Instance for which ancestors are being looked up.
  # @yield Block used to match parent. The parameter is the parent instance, the return value true
  #        or false, reflecting whether or not block matched ancestor.
  # @example
  #   ::ParallelAncestry.ancestor( some_instance ) do |this_parent|
  #     if this_parent.matches_arbitrary_condition
  #       true
  #     else
  #       false
  #     end
  #   end
  # @return [Array<Object>] An array containing references to parents matching block condition.
  def ancestor_chain( instance, & match_ancestor_block )
    
    ancestor_chain = [ this_ancestor = instance ]

    while this_ancestor = ancestor( this_ancestor, & match_ancestor_block )
      ancestor_chain.push( this_ancestor )
    end
    
    return ancestor_chain
    
  end

  ####################
  #  lowest_parents  #
  ####################
  
  # Returns the lowest parent in each parent tree matching block condition. For simple linear
  # trees, this is simply the first parent, but more complex trees quickly diverge into multiple
  # branches, each of which then requires a lowest match.
  # @param [Object] instance Instance for which parents are being looked up.
  # @yield Block used to match parent. The parameter is the parent instance, the return value true
  #        or false, reflecting whether or not block matched ancestor.
  # @example
  #   ::ParallelAncestry.lowest_parents( some_instance ) do |this_parent|
  #     if this_parent.matches_arbitrary_condition
  #       true
  #     else
  #       false
  #     end
  #   end
  # @return [Array<Object>] An array containing references to lowest parent in each parent tree 
  #   matching block condition.
  def lowest_parents( instance, & match_ancestor_block )

    # the first super module available for each tree

    lowest_parents_array = [ ]

    parents( instance ).each do |this_parent|
      
      # if we match this parent we are done with this branch and can go to the next
      if match_ancestor_block.call( this_parent )

        lowest_parents_array.push( this_parent )

      # otherwise our branch expands and we have to finish it before the next parent
      elsif has_parents?( this_parent )

        parents_for_branch = lowest_parents( this_parent, & match_ancestor_block )

        lowest_parents_array.concat( parents_for_branch )

      end
      
    end

    return lowest_parents_array
    
  end

  ######################
  #  highest_children  #
  ######################
  
  # Returns the highest parent in each parent tree matching block condition. For simple linear
  # trees, this is simply the first parent, but more complex trees quickly diverge into multiple
  # branches, each of which then requires a highest match.
  # @param [Object] instance Instance for which parents are being looked up.
  # @yield Block used to match parent. The parameter is the parent instance, the return value true
  #        or false, reflecting whether or not block matched ancestor.
  # @example
  #   ::ParallelAncestry.highest_parents( some_instance ) do |this_parent|
  #     if this_parent.matches_arbitrary_condition
  #       true
  #     else
  #       false
  #     end
  #   end
  # @return [Array<Object>] An array containing references to highest parent in each parent tree 
  #   matching block condition.
  def highest_children( instance, & match_ancestor_block )

    # the first super module available for each tree

    highest_children_array = [ ]

    children( instance ).each do |this_child|
      
      # if we match this parent we are done with this branch and can go to the next
      if match_ancestor_block.call( this_child )

        highest_children_array.push( this_child )

      # otherwise our branch expands and we have to finish it before the next parent
      elsif has_children?( this_child )

        children_for_branch = highest_children( this_child, & match_ancestor_block )

        highest_children_array.concat( children_for_branch )

      end
      
    end

    return highest_children_array
    
  end
  
  #####################################
  #  match_ancestor_searching_upward  #
  #####################################

  # Returns the first ancestor (determined by ancestor_match_block) for which match_block is true.
  # @param [Object] instance Instance for which parents are being looked up.
  # @param [Proc] ancestor_match_block Proc used to match parent. The parameter is the parent 
  #        instance, the return value true or false, reflecting whether or not block matched 
  #        ancestor.
  # @yield Block used to match parent. The parameter is the parent instance, the return value true
  #        or false, reflecting whether or not block matched.
  # @example
  #   ancestor_match_block = ::Proc.new do |this_parent|
  #     if this_parent.matches_arbitrary_condition
  #       true
  #     else
  #       false
  #     end
  #   end
  #   ::ParallelAncestry.match_ancestor_searching_upward( some_instance, 
  #                                                       ancestor_match_block ) do |this_parent|
  #     if this_parent.matches_arbitrary_condition
  #       true
  #     else
  #       false
  #     end
  #   end
  # @return [Object] 
  def match_ancestor_searching_upward( instance, ancestor_match_block, & match_block )

    matched_value = nil
    
    this_ancestor = instance

    if this_ancestor.is_a?( ::Module ) or
       has_parents?( this_ancestor )
      
      begin
        if match_block.call( this_ancestor )
          matched_value = this_ancestor
          break
        end
      end while this_ancestor = ancestor( this_ancestor, & ancestor_match_block )
    
    elsif match_block.call( this_ancestor )

      matched_value = this_ancestor
      
    else

      matched_value = match_ancestor_searching_upward( this_ancestor.class, 
                                                       ancestor_match_block,
                                                       & match_block )
      
    end
    
    return matched_value
    
  end
  
  ##################################################################################################
      private ######################################################################################
  ##################################################################################################

  #####################
  #  ancestor_struct  #
  #####################
  
  def ancestor_struct( instance )
    
    unless ancestor_struct = @ancestors_hash[ instance.__id__ ]
      # fill in slots lazily
      ancestor_struct = ::ParallelAncestry::InstanceAncestryStruct.new
      @ancestors_hash[ instance.__id__ ] = ancestor_struct
    end
    
    return ancestor_struct
    
  end

  ###################
  #  children_hash  #
  ###################
  
  def children_hash( instance )
    
    return ancestor_struct( instance ).children_hash ||= { }

  end

  ##################
  #  parents_hash  #
  ##################
  
  def parents_hash( instance )
    
    return ancestor_struct( instance ).parents_hash ||= { }

  end

  ###################
  #  parents_array  #
  ###################
  
  def parents_array( instance )
    
    return ancestor_struct( instance ).parents_array ||= [ ]

  end

end
