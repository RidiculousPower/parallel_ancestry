# -*- encoding : utf-8 -*-

[
  
  '../lib_ext/object',
  '../lib_ext/module'

].each { |this_file| require_relative( this_file << '.rb' ) }
