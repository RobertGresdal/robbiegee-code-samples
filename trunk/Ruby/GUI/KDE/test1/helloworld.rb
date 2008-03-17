require 'Qt'

a = Qt::Application.new(ARGV)

hello = Qt::PushButton.new("Hello World!", nil)
hello.resize(100, 30)

a.mainWidget = hello
hello.show()

a.exec()