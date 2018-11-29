using Sockets
import JSON

include("EventHandler.jl")
include("MsgHandler.jl")

server = listen(8000)
while true
    sock = accept(server)
    while isopen(sock)

      # get events
      recv = MsgHandler.msgRecv(sock)

      # handle events
      MsgHandler.msgHandle(recv)


      asts = EventHandler.readSourceToAST(ARGS[1])
      EventHandler.run(asts)

      # prepare respond
      response = MsgHandler.msgCreate(id, "result")

      # send events
      write(sock, response)
    end
end