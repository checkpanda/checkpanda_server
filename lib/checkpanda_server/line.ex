defmodule CheckpandaServer.Line do
  @endpoint_url_base "https://api.line.me/oauth2/v2.1"

  def verify_token(token) do
    token
    |> verify_token_url()
    |> HTTPoison.get()
    |> decode_response()
  end

  defp endpoint(path) do
    "#{@endpoint_url_base}/#{path}"
  end

  defp verify_token_url(token) do
    endpoint("/verify") <> "?access_token=" <> token
  end

  defp decode_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body)}
  end
  defp decode_response({:ok, %HTTPoison.Response{status_code: code}, body: body}) do
    {:error, :status_not_ok, code, body}
  end
  defp decode_response({:error, err}), do: {:error, err}
end
