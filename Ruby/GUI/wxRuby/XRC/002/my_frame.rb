
# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: basic_controls.xrc 
# Generated at: Mon Mar 17 23:52:03 +0100 2008

class BasicControls < Wx::Dialog
  
  def initialize(parent = nil)
    super()
    xml = Wx::XmlResource.get
    xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
    xml.init_all_handlers
    xml.load("basic_controls.xrc")
    xml.load_dialog_subclass(self, parent, "ID_BASICCONTROLS")

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
    
  end
end



# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: basic_controls.xrc 
# Generated at: Mon Mar 17 23:52:03 +0100 2008

class BasicControls < Wx::Dialog
  
  def initialize(parent = nil)
    super()
    xml = Wx::XmlResource.get
    xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
    xml.init_all_handlers
    xml.load("basic_controls.xrc")
    xml.load_dialog_subclass(self, parent, "ID_BASICCONTROLS")

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
    
  end
end



# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: basic_controls.xrc 
# Generated at: Mon Mar 17 23:52:03 +0100 2008

class ComplexDialog < Wx::Dialog
  
  def initialize(parent = nil)
    super()
    xml = Wx::XmlResource.get
    xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
    xml.init_all_handlers
    xml.load("basic_controls.xrc")
    xml.load_dialog_subclass(self, parent, "ID_COMPLEXDIALOG")

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
    
  end
end



# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: basic_controls.xrc 
# Generated at: Mon Mar 17 23:52:03 +0100 2008

class AdvancedControls < Wx::Dialog
  
  def initialize(parent = nil)
    super()
    xml = Wx::XmlResource.get
    xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
    xml.init_all_handlers
    xml.load("basic_controls.xrc")
    xml.load_dialog_subclass(self, parent, "ID_ADVANCEDCONTROLS")

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
    
  end
end



# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: basic_controls.xrc 
# Generated at: Mon Mar 17 23:52:03 +0100 2008

class ScrollingDialog < Wx::Dialog
  
  def initialize(parent = nil)
    super()
    xml = Wx::XmlResource.get
    xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
    xml.init_all_handlers
    xml.load("basic_controls.xrc")
    xml.load_dialog_subclass(self, parent, "ID_SCROLLINGDIALOG")

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
    
  end
end



# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: basic_controls.xrc 
# Generated at: Mon Mar 17 23:52:03 +0100 2008

class SplitterDialog < Wx::Dialog
  
  def initialize(parent = nil)
    super()
    xml = Wx::XmlResource.get
    xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
    xml.init_all_handlers
    xml.load("basic_controls.xrc")
    xml.load_dialog_subclass(self, parent, "ID_SPLITTERDIALOG")

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
    
  end
end



# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: basic_controls.xrc 
# Generated at: Mon Mar 17 23:52:03 +0100 2008

class TopDialog < Wx::Dialog
  
  def initialize(parent = nil)
    super()
    xml = Wx::XmlResource.get
    xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
    xml.init_all_handlers
    xml.load("basic_controls.xrc")
    xml.load_dialog_subclass(self, parent, "ID_TOPDIALOG")

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
    
  end
end



# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: basic_controls.xrc 
# Generated at: Mon Mar 17 23:52:03 +0100 2008

class MyFrame < Wx::Frame
  
  def initialize(parent = nil)
    super()
    xml = Wx::XmlResource.get
    xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
    xml.init_all_handlers
    xml.load("basic_controls.xrc")
    xml.load_frame_subclass(self, parent, "ID_FRAME")

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
    
  end
end


