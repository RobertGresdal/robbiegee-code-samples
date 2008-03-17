 require 'wx'
 # load in the generated code
 require 'my_frame'

 # Inherit from the generated base class and set up event handlers
 class CaseChangeFrame < Foo
   def initialize
     super
     #evt_button(upper_bt) { text_box.upcase! }
     #evt_button(lower_bt) { text_box.downcase! }
   end
 end

 # Run the class
 Wx::App.run do 
   CaseChangeFrame.new.show
 end