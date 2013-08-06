
require_relative 'support/named_class_and_module.rb'

def initialize_base_test_setup

  let( :module_instance ) { ::Module.new.name( :ModuleInstance ) }
  let( :class_instance )  { ::Class.new.name( :ClassInstance ) }
  let( :subclass )        { ::Class.new( class_instance ).name( :Subclass ) }

  let( :instance_of_object )   { ::Object.new.name( :ObjectInstance ) }
  let( :instance_of_class )    { class_instance.new.name( :ClassInstance ) }
  let( :instance_of_subclass ) { subclass.new.name( :Subclass ) }

end
