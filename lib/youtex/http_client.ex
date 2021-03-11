defmodule Youtex.HttpClient do
  @moduledoc false

  alias HTTPoison.Error
  alias HTTPoison.Response

  @spec get(String.t()) :: {:ok, any} | {:error, any}
  def get(url) do
    HTTPoison.get(url)
    |> handle_response()
  end

  defp handle_response({:ok, %Response{status_code: code, body: body}}) when code == 200,
    do: {:ok, body}

  defp handle_response({:ok, %Response{status_code: code}}) when code == 404,
    do: {:error, :not_found}

  defp handle_response({:error, %Error{reason: reason}}), do: {:error, reason}

  defp handle_response(response), do: {:error, response}
end
