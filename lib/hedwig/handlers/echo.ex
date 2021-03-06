defmodule Hedwig.Handlers.Echo do
  @moduledoc """
  A completely useless echo script.

  This script simply echoes the same message back.
  """

  @usage nil

  use Hedwig.Handler

  def handle_event(%Message{} = msg, opts) do
    reply(msg, msg.body)
    {:ok, opts}
  end

  def handle_event(_, opts), do: {:ok, opts}
end
