require 'opengl'
require 'glut'

GLUT.Init
GLUT.InitDisplayMode(GLUT::DEPTH | GLUT::SINGLE | GLUT::RGB)
GLUT.InitWindowSize(320,320)
GLUT.CreateWindow("Hello world!!")

GL.Vertex(0.1, 0.1, 0.0)
GL.Vertex(0.5, 0.1, 0.0)
GL.Vertex(0.5, 0.5, 0.0)
GL.Vertex(0.1, 0.5, 0.0)
