defmodule Issues.GithubIssues do
    require Logger

    @user_agent [{"User-agent", "Issue parser"}]
    @github_url Application.get_env(:issues, :github_url)

    @moduledoc """
    Handles fetching and decoding GitHub issues for a given project.
    """

    @doc """
    Given a string for a GitHub user and a string for a GitHub project
    the issues for that project are fetched and the response is decoded.
    """
    def fetch(user, project) do
        Logger.info("Fetching user #{user}'s project #{project}")
        issues_url(user, project)
        |> HTTPoison.get(@user_agent)
        |> handle_response
    end

    defp issues_url(user, project) do
        "#{@github_url}/repos/#{user}/#{project}/issues"
    end
    
    defp handle_response({:ok, %{status_code: 200, body: body}}) do
        Logger.info("Successful response")
        Logger.debug(fn -> inspect(body) end)
        {:ok, :jsx.decode(body)}
    end

    defp handle_response({:ok, %{status_code: status, body: body}}) do
        Logger.error("Error #{status} returned")
        {:error, :jsx.decode(body)}
    end
end