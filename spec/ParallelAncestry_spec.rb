
require_relative '../lib/parallel-ancestry.rb'

describe ::ParallelAncestry do

  before :all do
    module ::ParallelAncestry::Mock
      extend ::ParallelAncestry
    end
    class ::ParallelAncestry::ModuleSubclassMock < ::Module
      include ::ParallelAncestry
    end
    ::ParallelAncestry::ModuleSubclassInstanceMock = ::ParallelAncestry::ModuleSubclassMock.new
  end

  ##############
  #  children  #
  ##############

  it 'tracks an array of children' do
    [ ::ParallelAncestry::Mock, ::ParallelAncestry::ModuleSubclassInstanceMock ].each do |this_test|
      this_test.module_eval do
        configuration_instance = ::Module.new
        children_instance = children( configuration_instance )
        children_instance.should == []
        children_instance.should == children( configuration_instance )
      end
    end
  end

  #############
  #  parents  #
  #############

  it 'tracks an array of children' do
    [ ::ParallelAncestry::Mock, ::ParallelAncestry::ModuleSubclassInstanceMock ].each do |this_test|
      this_test.module_eval do
        configuration_instance = ::Module.new
        parents_instance = parents( configuration_instance )
        parents_instance.should == []
        parents_instance.should == parents( configuration_instance )
      end
    end
  end
  
  ###############################
  #  register_child_for_parent  #
  ###############################

  it 'can register children for a given instance so that migration is possible' do
    [ ::ParallelAncestry::Mock, ::ParallelAncestry::ModuleSubclassInstanceMock ].each do |this_test|
      this_test.module_eval do
        parent = ::Module.new
        child = ::Module.new
        register_child_for_parent( child, parent )
        children( parent ).should == [ child ]
      end
    end
  end

  ##############
  #  ancestor  #
  ##############

  it 'can return the next ancestor for instance for configuration name' do
    [ ::ParallelAncestry::Mock, ::ParallelAncestry::ModuleSubclassInstanceMock ].each do |this_test|
      this_test.module_eval do
        parent = ::Module.new do
          # we have to mock the method bc that's how the module determines if it has a configuration defined
          # since we don't know whether a configuration value has been set yet
          attr_accessor :some_configuration
        end
        child = ::Module.new
        register_child_for_parent( child, parent )
        ancestor( child ) { |this_parent| this_parent == parent } .should == parent
      end
    end
  end

  ####################
  #  ancestor_chain  #
  ####################
  
  it 'can return a chain of instances corresponding to the configuration inheritance chain' do
    [ ::ParallelAncestry::Mock, ::ParallelAncestry::ModuleSubclassInstanceMock ].each do |this_test|
      this_test.module_eval do
        # set up hierarchy
        instance_A = ::Module.new do
          # we have to mock the method bc that's how the module determines if it has a configuration defined
          # since we don't know whether a configuration value has been set yet
          attr_accessor :some_configuration
        end
        instance_B = ::Module.new do
          # we have to mock the method bc that's how the module determines if it has a configuration defined
          # since we don't know whether a configuration value has been set yet
          attr_accessor :some_other_configuration
          include instance_A
        end
        register_child_for_parent( instance_B, instance_A )
        instance_C1 = ::Module.new do
          include instance_B
          attr_accessor :yet_another_configuration
        end
        register_child_for_parent( instance_C1, instance_B )
        instance_C2 = ::Module.new do
          include instance_B
        end
        register_child_for_parent( instance_C2, instance_B )
        instance_D = ::Module.new do
          include instance_C1
          include instance_C2
        end
        register_child_for_parent( instance_D, instance_C1 )
        register_child_for_parent( instance_D, instance_C2 )
        # test ancestor hierarchy for each
        ancestor_proc = ::Proc.new do |this_parent|
          this_parent.method_defined?( :some_configuration )
        end
        ancestor_chain( instance_A, & ancestor_proc ).should == [ instance_A ]
        ancestor_chain( instance_B, & ancestor_proc ).should == [ instance_B, instance_A ]
        ancestor_chain( instance_C1, & ancestor_proc ).should == [ instance_C1, instance_B, instance_A ]
        ancestor_chain( instance_C2, & ancestor_proc ).should == [ instance_C2, instance_B, instance_A ]
        ancestor_chain( instance_D, & ancestor_proc ).should == [ instance_D, instance_C2, instance_B, instance_A ]

        ancestor_proc = ::Proc.new do |this_parent|
          this_parent.method_defined?( :some_other_configuration )
        end
        ancestor_chain( instance_B, & ancestor_proc ).should == [ instance_B ]
        ancestor_chain( instance_C1, & ancestor_proc ).should == [ instance_C1, instance_B ]
        ancestor_chain( instance_C2, & ancestor_proc ).should == [ instance_C2, instance_B ]

        ancestor_proc = ::Proc.new do |this_parent|
          this_parent.method_defined?( :yet_another_configuration )
        end
        ancestor_chain( instance_C1, & ancestor_proc ).should == [ instance_C1 ]
        ancestor_chain( instance_D, & ancestor_proc ).should == [ instance_D, instance_C1 ]
      end
    end
  end

  ####################
  #  lowest_parents  #
  ####################

  it 'can return the first ancestor on each parent tree matching block condition' do
    [ ::ParallelAncestry::Mock, ::ParallelAncestry::ModuleSubclassInstanceMock ].each do |this_test|
      this_test.module_eval do
        # set up hierarchy
        instance_A = ::Module.new do
          # we have to mock the method bc that's how the module determines if it has a configuration defined
          # since we don't know whether a configuration value has been set yet
          attr_accessor :some_configuration
        end
        instance_B1 = ::Module.new do
          # we have to mock the method bc that's how the module determines if it has a configuration defined
          # since we don't know whether a configuration value has been set yet
          attr_accessor :some_other_configuration
          include instance_A
        end
        register_child_for_parent( instance_B1, instance_A )
        instance_B2 = ::Module.new do
          include instance_A
        end
        register_child_for_parent( instance_B2, instance_A )
        instance_C1 = ::Module.new do
          include instance_B1
          attr_accessor :yet_another_configuration
        end
        register_child_for_parent( instance_C1, instance_B1 )
        instance_C2 = ::Module.new do
          include instance_B1
        end
        register_child_for_parent( instance_C2, instance_B1 )
        instance_D = ::Module.new do
          include instance_B2
          include instance_C1
          include instance_C2
        end
        instance_E = ::Class.new do
          include instance_B2
          include instance_C1
          include instance_C2
          include instance_D
        end
        register_child_for_parent( instance_D, instance_B2 )
        register_child_for_parent( instance_D, instance_C1 )
        register_child_for_parent( instance_D, instance_C2 )
        register_child_for_parent( instance_E, instance_D )
        register_child_for_parent( instance_E, instance_B1 )
        match_proc = ::Proc.new do |this_parent|
          this_parent.method_defined?( :some_configuration )
        end
        lowest_parents( instance_D, & match_proc ).should == [ instance_C2, instance_C1, instance_B2 ]
        lowest_parents( instance_C2, & match_proc ).should == [ instance_B1 ]
        lowest_parents( instance_C1, & match_proc ).should == [ instance_B1 ]
        lowest_parents( instance_B1, & match_proc ).should == [ instance_A ]
        lowest_parents( instance_B2, & match_proc ).should == [ instance_A ]
        lowest_parents( instance_E, & match_proc ).should == [ instance_B1, instance_D ]
      end
    end
  end

  ######################
  #  highest_children  #
  ######################

  it 'can return the first ancestor on each child tree matching block condition' do
    [ ::ParallelAncestry::Mock, ::ParallelAncestry::ModuleSubclassInstanceMock ].each do |this_test|
      this_test.module_eval do
        # set up hierarchy
        instance_A = ::Module.new do
          # we have to mock the method bc that's how the module determines if it has a configuration defined
          # since we don't know whether a configuration value has been set yet
          attr_accessor :some_configuration
        end
        instance_B1 = ::Module.new do
          # we have to mock the method bc that's how the module determines if it has a configuration defined
          # since we don't know whether a configuration value has been set yet
          attr_accessor :some_other_configuration
          extend instance_A
        end
        register_child_for_parent( instance_B1, instance_A )
        instance_B2 = ::Module.new do
          extend instance_A
        end
        register_child_for_parent( instance_B2, instance_A )
        instance_C1 = ::Module.new do
          extend instance_B1
          extend instance_A
          attr_accessor :yet_another_configuration
        end
        register_child_for_parent( instance_C1, instance_B1 )
        instance_C2 = ::Module.new do
          extend instance_B2
          extend instance_A
        end
        register_child_for_parent( instance_C2, instance_B1 )
        instance_D = ::Module.new do
          extend instance_B2
          extend instance_C1
          extend instance_A
        end
        instance_E = ::Class.new do
          extend instance_C2
        end
        register_child_for_parent( instance_D, instance_B2 )
        register_child_for_parent( instance_D, instance_C1 )
        register_child_for_parent( instance_D, instance_C2 )
        register_child_for_parent( instance_E, instance_D )
        register_child_for_parent( instance_E, instance_B1 )
        match_proc = ::Proc.new do |this_parent|
          this_parent.respond_to?( :some_configuration )
        end
        highest_children( instance_E, & match_proc ).empty?.should == true
        highest_children( instance_D, & match_proc ).empty?.should == true
        highest_children( instance_C2, & match_proc ).should == [ instance_D ]
        highest_children( instance_C1, & match_proc ).should == [ instance_D ]
        highest_children( instance_B1, & match_proc ).should == [ instance_C1, instance_C2 ]
        highest_children( instance_B2, & match_proc ).should == [ instance_D ]
        highest_children( instance_A, & match_proc ).should == [ instance_B1, instance_B2 ]
      end
    end
  end
  
  #####################################
  #  match_ancestor  #
  #####################################

  it 'can get the first defined configuration searching up the module configuration inheritance chain' do
    [ ::ParallelAncestry::Mock, ::ParallelAncestry::ModuleSubclassInstanceMock ].each do |this_test|
      this_test.module_eval do
        # set up hierarchy
        instance_A = ::Module.new do
          # we have to mock the method bc that's how the module determines if it has a configuration defined
          # since we don't know whether a configuration value has been set yet
          class << self
            attr_accessor :some_configuration
          end
        end
        instance_B = ::Module.new do
          # we have to mock the method bc that's how the module determines if it has a configuration defined
          # since we don't know whether a configuration value has been set yet
          include instance_A
          class << self
            attr_accessor :some_configuration
            attr_accessor :some_other_configuration
          end
        end
        register_child_for_parent( instance_B, instance_A )
        instance_C1 = ::Module.new do
          include instance_B
          class << self
            attr_accessor :some_configuration
            attr_accessor :some_other_configuration
            attr_accessor :yet_another_configuration
          end
        end
        register_child_for_parent( instance_C1, instance_B )
        instance_C2 = ::Module.new do
          include instance_B
          class << self
            attr_accessor :some_configuration
            attr_accessor :some_other_configuration
            attr_accessor :yet_another_configuration
          end
        end
        register_child_for_parent( instance_C2, instance_B )
        instance_D = ::Module.new do
          include instance_C1
          include instance_C2
          class << self
            attr_accessor :some_configuration
            attr_accessor :some_other_configuration
            attr_accessor :yet_another_configuration
          end
        end
        register_child_for_parent( instance_D, instance_C1 )
        register_child_for_parent( instance_D, instance_C2 )

        configuration_method = :some_configuration

        # test ancestor hierarchy for each
        match_proc = ::Proc.new do |this_parent|        
          this_parent.__send__( configuration_method )
        end
      
        match_ancestor_proc = ::Proc.new do |this_parent|
          this_parent.respond_to?( configuration_method )
        end
      
        instance_A.some_configuration = :some_value
        instance_B.some_other_configuration = :some_other_value
      
        match_ancestor( instance_B, match_ancestor_proc, & match_proc ).should == instance_A   
        match_ancestor( instance_C1, match_ancestor_proc, & match_proc ).should == instance_A

        configuration_method = :some_other_configuration
        match_ancestor( instance_B, match_ancestor_proc, & match_proc ).should == instance_B
        match_ancestor( instance_C1, match_ancestor_proc, & match_proc ).should == instance_B

        instance_C2.yet_another_configuration = :another_value

        configuration_method = :yet_another_configuration
        match_ancestor( instance_C1, match_ancestor_proc, & match_proc ).should == nil
        match_ancestor( instance_D, match_ancestor_proc, & match_proc ).should == instance_C2

        configuration_method = :some_configuration
        match_ancestor( instance_C2, match_ancestor_proc, & match_proc ).should == instance_A
        match_ancestor( instance_D, match_ancestor_proc, & match_proc ).should == instance_A

        configuration_method = :some_other_configuration
        match_ancestor( instance_C2, match_ancestor_proc, & match_proc ).should == instance_B
        match_ancestor( instance_D, match_ancestor_proc, & match_proc ).should == instance_B

      end    
    end
  end
  
end
