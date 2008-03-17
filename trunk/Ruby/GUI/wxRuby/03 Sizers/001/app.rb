require 'rubygems'
require 'wx'

class MyBadApp < Wx::App
  def on_init()
    frame = Wx::Frame.new(nil, -1, 'WxRuby without sizers')
    # make the frame leave 200 x 200 pixels of space for the widgets
    frame.set_client_size(Wx::Size.new(200,200))
    # put the new text control in the top left corner of the frame(0,0)
    text = Wx::TextCtrl.new(frame, -1, 'Type in here',
                            Wx::Point.new(0,0), Wx::Size.new(200,175),
                            Wx::TE_MULTILINE)
    button = Wx::Button.new(frame, -1, 'Click on this',
                            Wx::Point.new(100,175), Wx::Size.new(100,25))
    frame.show()
  end
end
MyBadApp.new().main_loop()