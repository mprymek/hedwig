defmodule Hedwig.Transport do
  @moduledoc """
  Transport specification.
  """

  alias Hedwig.Conn

  @type conn   :: Conn.t
  @type opts   :: any
  @type socket :: port
  @type data   :: term

  use Behaviour

  @doc false
  defmacro __using__(_opts) do
    quote location: :keep do
      @behaviour Hedwig.Transport
      require Logger
      use GenServer
      alias unquote(__MODULE__)
      alias __MODULE__
    end
  end

  defcallback start(conn) :: conn
  defcallback send(conn, data) :: conn
  defcallback connected?(conn) :: boolean
  defcallback upgrade_to_tls({conn, list})
  defcallback use_zlib({conn, opts})
  defcallback get_transport(conn)
  defcallback reset_parser(conn)
  defcallback stop(conn)

  @doc """
  Returns the correct module for the given value.

  ## Examples
      iex> Hedwig.Transport.module(:tcp)
      Hedwig.Transports.TCP
  """
  def module(transport) do
    case Atom.to_string(transport) do
      "Elixir." <> _ -> transport
      reference -> Module.concat(Hedwig.Transports, String.upcase(reference))
    end
  end
end
