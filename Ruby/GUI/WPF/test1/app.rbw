# tutorial on http://techblogging.wordpress.com/2007/10/09/creating-a-user-interface-in-ruby-using-wpf/
# remember there are lots of utf8 invalid characters in the online example

# load the libraries
require 'rubygems'
require 'wpf'
# load the xaml file
window = XamlReader.Load(System::IO::File.open_read('ui.xaml'))
 
# get the controls
button = window.find_name('the_button')
txt_box = window.find_name('the_text_box')

# trap the mouse enter event
button.mouse_enter do |sender, args|
    txt_box.text += "MOUSE ENTERED\n"
end

# trap the mouse leave event
button.mouse_leave do |sender, args|
    txt_box.text += "MOUSE LEFT\n"
end

# trap the mouse click event
button.click do |sender, args|
    txt_box.text += "MOUSE CLICKED\n"
end

# run the application (most important)
Application.new.run(window)
