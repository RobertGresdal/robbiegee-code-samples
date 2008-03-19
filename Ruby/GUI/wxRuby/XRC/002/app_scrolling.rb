require 'rubygems'
 require 'wx'
 # load in the generated code
 require 'my_frame'

 # Run the class
 Wx::App.run do 
   ScrollingDialog.new.show
 end
