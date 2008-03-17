
# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: gui.xrc 
# Generated at: Mon Mar 17 15:43:16 +0100 2008

class Foo < Wx::Frame
  
  attr_reader :mainpanel, :button
  
  def initialize(parent = nil)
    super()
    xml = Wx::XmlResource.get
    xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
    xml.init_all_handlers
    xml.load("gui.xrc")
    xml.load_frame_subclass(self, parent, "mainFrame")

    finder = lambda do | x | 
      int_id = Wx::xrcid(x)
      begin
        Wx::Window.find_window_by_id(int_id, self) || int_id
      # Temporary hack to work around regression in 1.9.2; remove
      # begin/rescue clause in later versions
      rescue RuntimeError
        int_id
      end
    end
    
    @mainpanel = finder.call("mainPanel")
    @button = finder.call("button")
  end
end


