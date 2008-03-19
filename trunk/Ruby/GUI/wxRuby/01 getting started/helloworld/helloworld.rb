require 'rubygems'
require "wx"
 include Wx
 class HelloWorld < App  # a new class which derives from the Wx::App class
   def on_init  # we're defining what the application is going to do when it starts
     helloframe = Frame.new(nil, -1, "Hello World")  # it's going to make a frame entitled "Hello World"
     StaticText.new(helloframe,-1,"Hello World")  # it's going to put the text "Hello World" in that frame
     helloframe.show()  # and then it's going to make the window appear
   end
 end
 HelloWorld.new.main_loop  # and this line makes it actually do it! 
