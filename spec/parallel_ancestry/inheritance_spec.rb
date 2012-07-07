
require_relative '../../lib/parallel_ancestry.rb'

describe ::ParallelAncestry::Inheritance do

  it 'can enable hooks in module extended with self' do
    module ::ParallelAncestry::Inheritance::ModuleMock
      
      # mock to ensure call
      def self.initialize_inheritance_for_module!
        super
        @ran_initialize_inheritance_for_module = true
      end
      def self.ran_initialize_inheritance_for_module?
        returning_ran_initialize_inheritance_for_module = ( @ran_initialize_inheritance_for_module ? true : false )
        @ran_initialize_inheritance_for_module = false
        return returning_ran_initialize_inheritance_for_module
      end
      # mock to ensure call
      def self.initialize_base_instance_for_include( inheriting_instance )
        super
        @ran_initialize_base_instance_for_include = true
      end
      def self.ran_initialize_base_instance_for_include?
        returning_ran_initialize_base_instance_for_include = ( @ran_initialize_base_instance_for_include ? true : false )
        @ran_initialize_base_instance_for_include = false
        return returning_ran_initialize_base_instance_for_include
      end
      # mock to ensure call
      def self.initialize_base_instance_for_extend( inheriting_instance )
        super
        @ran_initialize_base_instance_for_extend = true
      end
      def self.ran_initialize_base_instance_for_extend?
        returning_ran_initialize_base_instance_for_extend = ( @ran_initialize_base_instance_for_extend ? true : false )
        @ran_initialize_base_instance_for_extend = false
        return returning_ran_initialize_base_instance_for_extend
      end
      # mock to ensure call
      def self.initialize_inheritance( inheriting_instance )
        super
        @ran_initialize_inheritance = true
      end
      def self.ran_initialize_inheritance?
        returning_ran_initialize_inheritance = ( @ran_initialize_inheritance ? true : false )
        @ran_initialize_inheritance = false
        return returning_ran_initialize_inheritance
      end
      # mock to ensure call
      def self.initialize_inheriting_instance( parent_instance, inheriting_instance, is_subclass = false )
        super
        @ran_initialize_inheriting_instance = true
      end
      def self.ran_initialize_inheriting_instance?
        returning_ran_initialize_inheriting_instance = ( @ran_initialize_inheriting_instance ? true : false )
        @ran_initialize_inheriting_instance = false
        return returning_ran_initialize_inheriting_instance
      end
      
      extend ::ParallelAncestry::Inheritance
      
      ran_initialize_inheritance_for_module?.should == true
      ran_initialize_base_instance_for_include?.should == false
      ran_initialize_base_instance_for_extend?.should == false
      ran_initialize_inheritance?.should == false
      ran_initialize_inheriting_instance?.should == false
      
      module IncludingModuleMock
        include ::ParallelAncestry::Inheritance::ModuleMock
      end

      ran_initialize_inheritance_for_module?.should == false
      ran_initialize_base_instance_for_include?.should == true
      ran_initialize_base_instance_for_extend?.should == false
      ran_initialize_inheritance?.should == true
      ran_initialize_inheriting_instance?.should == false

      module ExtendingModuleMock
        extend ::ParallelAncestry::Inheritance::ModuleMock
      end

      ran_initialize_inheritance_for_module?.should == false
      ran_initialize_base_instance_for_include?.should == false
      ran_initialize_base_instance_for_extend?.should == true
      ran_initialize_inheritance?.should == false
      ran_initialize_inheriting_instance?.should == false

      module SubIncludingModuleMock
        include ::ParallelAncestry::Inheritance::ModuleMock::IncludingModuleMock
      end

      ran_initialize_inheritance_for_module?.should == false
      ran_initialize_base_instance_for_include?.should == false
      ran_initialize_base_instance_for_extend?.should == false
      ran_initialize_inheritance?.should == true
      ran_initialize_inheriting_instance?.should == true

      module SubExtendingModuleMock
        extend ::ParallelAncestry::Inheritance::ModuleMock::ExtendingModuleMock
      end

      ran_initialize_inheritance_for_module?.should == false
      ran_initialize_base_instance_for_include?.should == false
      ran_initialize_base_instance_for_extend?.should == false
      ran_initialize_inheritance?.should == false
      ran_initialize_inheriting_instance?.should == false

      module SubSubIncludingModuleMock
        include ::ParallelAncestry::Inheritance::ModuleMock::SubIncludingModuleMock
      end

      ran_initialize_inheritance_for_module?.should == false
      ran_initialize_base_instance_for_include?.should == false
      ran_initialize_base_instance_for_extend?.should == false
      ran_initialize_inheritance?.should == true
      ran_initialize_inheriting_instance?.should == true

      module SubSubExtendingModuleMock
        extend ::ParallelAncestry::Inheritance::ModuleMock::SubExtendingModuleMock
      end
      
      ran_initialize_inheritance_for_module?.should == false
      ran_initialize_base_instance_for_include?.should == false
      ran_initialize_base_instance_for_extend?.should == false
      ran_initialize_inheritance?.should == false
      ran_initialize_inheriting_instance?.should == false
      
    end
    
  end

  it 'can enable hooks in module subclass including self' do
    class ::ParallelAncestry::Inheritance::ModuleSubclassMock < ::Module
      include ::ParallelAncestry::Inheritance
    end
    
    ::ParallelAncestry::Inheritance::ModuleSubclassInstanceMock = ::ParallelAncestry::Inheritance::ModuleSubclassMock.new
    module ::ParallelAncestry::Inheritance::ModuleSubclassInstanceMock
      
      # mock to ensure call
      def self.initialize_inheritance_for_module!
        super
        @ran_initialize_inheritance_for_module = true
      end
      def self.ran_initialize_inheritance_for_module?
        returning_ran_initialize_inheritance_for_module = ( @ran_initialize_inheritance_for_module ? true : false )
        @ran_initialize_inheritance_for_module = false
        return returning_ran_initialize_inheritance_for_module
      end
      # mock to ensure call
      def self.initialize_base_instance_for_include( inheriting_instance )
        super
        @ran_initialize_base_instance_for_include = true
      end
      def self.ran_initialize_base_instance_for_include?
        returning_ran_initialize_base_instance_for_include = ( @ran_initialize_base_instance_for_include ? true : false )
        @ran_initialize_base_instance_for_include = false
        return returning_ran_initialize_base_instance_for_include
      end
      # mock to ensure call
      def self.initialize_base_instance_for_extend( inheriting_instance )
        super
        @ran_initialize_base_instance_for_extend = true
      end
      def self.ran_initialize_base_instance_for_extend?
        returning_ran_initialize_base_instance_for_extend = ( @ran_initialize_base_instance_for_extend ? true : false )
        @ran_initialize_base_instance_for_extend = false
        return returning_ran_initialize_base_instance_for_extend
      end
      # mock to ensure call
      def self.initialize_inheritance( inheriting_instance )
        super
        @ran_initialize_inheritance = true
      end
      def self.ran_initialize_inheritance?
        returning_ran_initialize_inheritance = ( @ran_initialize_inheritance ? true : false )
        @ran_initialize_inheritance = false
        return returning_ran_initialize_inheritance
      end
      # mock to ensure call
      def self.initialize_inheriting_instance( parent_instance, inheriting_instance, is_subclass = false )
        super
        @ran_initialize_inheriting_instance = true
      end
      def self.ran_initialize_inheriting_instance?
        returning_ran_initialize_inheriting_instance = ( @ran_initialize_inheriting_instance ? true : false )
        @ran_initialize_inheriting_instance = false
        return returning_ran_initialize_inheriting_instance
      end
      
      extend ::ParallelAncestry::Inheritance
      
      ran_initialize_inheritance_for_module?.should == true
      ran_initialize_base_instance_for_include?.should == false
      ran_initialize_base_instance_for_extend?.should == false
      ran_initialize_inheritance?.should == false
      ran_initialize_inheriting_instance?.should == false
      
      module IncludingModuleMock
        include ::ParallelAncestry::Inheritance::ModuleSubclassInstanceMock
      end

      ran_initialize_inheritance_for_module?.should == false
      ran_initialize_base_instance_for_include?.should == true
      ran_initialize_base_instance_for_extend?.should == false
      ran_initialize_inheritance?.should == true
      ran_initialize_inheriting_instance?.should == false

      module ExtendingModuleMock
        extend ::ParallelAncestry::Inheritance::ModuleSubclassInstanceMock
      end

      ran_initialize_inheritance_for_module?.should == false
      ran_initialize_base_instance_for_include?.should == false
      ran_initialize_base_instance_for_extend?.should == true
      ran_initialize_inheritance?.should == false
      ran_initialize_inheriting_instance?.should == false

      module SubIncludingModuleMock
        include ::ParallelAncestry::Inheritance::ModuleSubclassInstanceMock::IncludingModuleMock
      end

      ran_initialize_inheritance_for_module?.should == false
      ran_initialize_base_instance_for_include?.should == false
      ran_initialize_base_instance_for_extend?.should == false
      ran_initialize_inheritance?.should == true
      ran_initialize_inheriting_instance?.should == true

      module SubExtendingModuleMock
        extend ::ParallelAncestry::Inheritance::ModuleSubclassInstanceMock::ExtendingModuleMock
      end

      ran_initialize_inheritance_for_module?.should == false
      ran_initialize_base_instance_for_include?.should == false
      ran_initialize_base_instance_for_extend?.should == false
      ran_initialize_inheritance?.should == false
      ran_initialize_inheriting_instance?.should == false

      module SubSubIncludingModuleMock
        include ::ParallelAncestry::Inheritance::ModuleSubclassInstanceMock::SubIncludingModuleMock
      end

      ran_initialize_inheritance_for_module?.should == false
      ran_initialize_base_instance_for_include?.should == false
      ran_initialize_base_instance_for_extend?.should == false
      ran_initialize_inheritance?.should == true
      ran_initialize_inheriting_instance?.should == true

      module SubSubExtendingModuleMock
        extend ::ParallelAncestry::Inheritance::ModuleSubclassInstanceMock::SubExtendingModuleMock
      end
      
      ran_initialize_inheritance_for_module?.should == false
      ran_initialize_base_instance_for_include?.should == false
      ran_initialize_base_instance_for_extend?.should == false
      ran_initialize_inheritance?.should == false
      ran_initialize_inheriting_instance?.should == false
      
    end
  end
  
end
