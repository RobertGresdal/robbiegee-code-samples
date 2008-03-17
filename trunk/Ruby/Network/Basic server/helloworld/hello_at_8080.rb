require 'gserver'

class BasicServer < GServer
    def serve(io)
        io.puts("Hello world!")
    end
end

server = BasicServer.new(8080)
server.start
sleep 60
server.shutdown