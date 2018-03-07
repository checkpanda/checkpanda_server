defmodule CheckpandaServer.Line do
  @auth_endpoint_base "https://api.line.me/oauth2/v2.1/"
  @endpoint_base "https://api.line.me/v2/"

  def verify_token(token) do
    token
    |> verify_token_url()
    |> HTTPoison.get()
    |> decode_response()
  end

  def user_profile(token) do
    headers = auth_headers(token)

    HTTPoison.get(endpoint("/profile"), headers)
    |> decode_response()
  end

  defp auth_endpoint(path) do
    Path.join(@auth_endpoint_base, path)
  end

  defp endpoint(path) do
    Path.join(@endpoint_base, path)
  end

  defp auth_headers(token) do
    [{"Authorization", "Bearer #{token}"}]
  end

  defp verify_token_url(token) do
    auth_endpoint("/verify") <> "?access_token=" <> token
  end

  defp decode_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body)}
  end

  defp decode_response({:ok, %HTTPoison.Response{status_code: code, body: body}}) do
    {:error, :status_not_ok, code, body}
  end

  defp decode_response({:error, err}), do: {:error, err}
end
