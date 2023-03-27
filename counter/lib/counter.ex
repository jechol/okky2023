defmodule Counter do
  defmodule Cache do
    use Nebulex.Cache,
      otp_app: :my_app,
      adapter: Nebulex.Adapters.Replicated
  end

  @moduledoc """
  Counter keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
end
