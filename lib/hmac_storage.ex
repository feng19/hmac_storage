defmodule HmacStorage do
  @moduledoc """
  Hub Http Client(HMac Auth) for WeChat Storage

  ### Example usage

      config :hmac_storage,
        hub_base_url: "https://wx-hub.example.com/api/hub/expose",
        client_id: "client_id",
        secret: "secret"
  """
  alias WeChat.Storage.Adapter
  @behaviour WeChat.Storage.Adapter

  @impl true
  @spec store(Adapter.store_id(), Adapter.store_key(), Adapter.value()) :: :ok | any
  def store(_store_id, _store_key, _value) do
    {:error, "Did not supported store value, this storage only used for hub_client."}
  end

  @impl true
  @spec restore(Adapter.store_id(), Adapter.store_key()) :: {:ok, Adapter.value()} | any
  def restore(store_id, store_key) do
    %{hub_base_url: hub_base_url, client_id: client_id, secret: secret} =
      Application.get_all_env(:hmac_storage) |> Map.new()

    Tesla.client(
      [
        {TeslaHmacAuth, client_id: client_id, secret: secret},
        Tesla.Middleware.DecodeJson,
        Tesla.Middleware.Logger
      ],
      WeChat.Utils.default_adapter()
    )
    |> Tesla.get("#{hub_base_url}/#{store_id}/#{store_key}")
    |> case do
      {:ok, %{status: 200, body: %{"error" => 0, "store_map" => store_map}}} -> {:ok, store_map}
      {:ok, %{status: 200, body: %{"msg" => error_msg}}} -> {:error, error_msg}
      _ -> {:error, "request error"}
    end
  end
end
