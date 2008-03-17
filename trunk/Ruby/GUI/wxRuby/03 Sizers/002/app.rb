require 'rubygems'
require 'wx'

class MyApp < Wx::App
  def on_init()
    frame = Wx::Frame.new(nil, -1, 'Sizer happiness')
    frame.set_client_size(Wx::Size.new(200,200))
    sizer = Wx::BoxSizer.new(Wx::VERTICAL)
    text = Wx::TextCtrl.new(frame, -1, 'Type in here',
                            Wx::DEFAULT_POSITION, Wx::DEFAULT_SIZE,
                            Wx::TE_MULTILINE)
    sizer.add(text, 1, Wx::GROW|Wx::ALL, 2)
    button = Wx::Button.new(frame, -1, 'Click on this')
    sizer.add(button, 0, Wx::ALIGN_RIGHT, 2)
    frame.set_sizer(sizer)
    frame.show()
  end
end

MyApp.new.main_loop()