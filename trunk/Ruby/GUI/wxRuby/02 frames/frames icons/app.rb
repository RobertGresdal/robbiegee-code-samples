require 'rubygems'
#~ #gem 'wxruby2-preview' # or the name of the gem you installed 
require "wx" # wxruby2
#~ #include Wx

#require "wxruby"

ID_ICON = 1000

class IconFrame < Wx::Frame
    def initialize
        super(nil, -1, "Changing Icons!", Wx::DEFAULT_POSITION, Wx::Size.new(225,150))
        panel = Wx::Panel.new(self, -1)
        iconNames = ["wxwin", "mondrian", "ogl", "smiley"]
        icons = Wx::RadioBox.new(panel, ID_ICON, "&Icons", Wx::Point.new(20,5),
                                 Wx::DEFAULT_SIZE, iconNames, 1, Wx::RA_SPECIFY_COLS)
        evt_radiobox(ID_ICON) {|event| on_change_icon(event)}
        
        icon = 
        if Wx::PLATFORM == "WXMSW"
            Wx::Icon.new("./icons/wxwin.ico", Wx::BITMAP_TYPE_ICO)
        else
            Wx::Icon.new("./icons/wxwin16x16.xpm", Wx::BITMAP_TYPE_XPM)
        end
        set_icon(icon)
        
        show(true) #true is the default value, so it may be left off
    end
    
    def on_change_icon(event)
        #if Wx::RUBY_PLATFORM == "WXMSW" # bug in the tutorial
        if Wx::PLATFORM == "WXMSW"
            case event.get_int
                when 0
                    set_icon(Wx::Icon.new("./icons/wxwin.ico", Wx::BITMAP_TYPE_ICO)) # needed to add the second parameter for icons to change
                when 1
                    set_icon(Wx::Icon.new("./icons/mondrian.ico", Wx::BITMAP_TYPE_ICO))
                when 2
                    set_icon(Wx::Icon.new("./icons/ogl.ico", Wx::BITMAP_TYPE_ICO))
                when 3
                    set_icon(Wx::Icon.new("./icons/smiley.ico", Wx::BITMAP_TYPE_ICO))
            end
        else
            case event.get_int
                when 0
                    set_icon(Wx::Icon.new("./icons/wxwin16x16.xpm"))
                when 1
                    set_icon(Wx::Icon.new("./icons/mondrian.xpm"))
                when 2
                    set_icon(Wx::Icon.new("./icons/ogl.xpm"))
                when 3
                    set_icon(Wx::Icon.new("./icons/smiley.xpm"))
            end
        end
    end
end

class MinimalApp < Wx::App
    def on_init
        IconFrame.new
    end
end

MinimalApp.new.main_loop