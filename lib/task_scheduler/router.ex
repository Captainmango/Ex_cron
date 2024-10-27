defmodule TaskScheduler.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    conn
    |> send_resp(Plug.Conn.Status.code(200), "hello world")
  end

  match _ do
    conn
    |> send_resp(404, "")
  end
end
