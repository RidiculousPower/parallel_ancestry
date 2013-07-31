
require_relative 'support/named_class_and_module.rb'

def initialize_test_setup

  let( :parallel_ancestry ) { ::ParallelAncestry::Standard }
  let( :extending_module )  { ::Module.new.name( :ExtendingModule ) }

  let( :module_instance ) { ::Module.new.name( :ModuleInstance ) }
  let( :class_instance )  { ::Class.new.name( :ClassInstance ) }
  let( :subclass )        { ::Class.new( class_instance ).name( :Subclass ) }

  let( :instance_of_object )   { ::Object.new.name( :ObjectInstance ) }
  let( :instance_of_class )    { class_instance.new.name( :ClassInstance ) }
  let( :instance_of_subclass ) { subclass.new.name( :Subclass ) }

  let( :module_extended_by_module )   { module_instance.extend( extending_module ).name( :ModuleExtendedByModule ) }
  let( :class_extended_by_module )    { class_instance.extend( extending_module ).name( :ClassExtendedByModule ) }
  let( :subclass_extended_by_module ) { subclass.extend( extending_module ).name( :SubclassExtendedByModule ) }

  let( :instance_of_object_extended_by_module )   { instance_of_object.extend( extending_module ).name( :InstanceOfObjectExtendedByModule ) }
  let( :instance_of_class_extended_by_module )    { instance_of_class.extend( extending_module ).name( :InstanceOfClassExtendedByModule ) }
  let( :instance_of_subclass_extended_by_module ) { instance_of_subclass.extend( extending_module ).name( :InstanceOfSubclassExtendedByModule ) }

end
