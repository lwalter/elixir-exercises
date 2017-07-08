defmodule Issues.CLI do
    @default_count 4

    @moduledoc """
    Handle the command line parsing and the dispatch to the various
    function that end up generating a table of the last _n_ issues 
    in a github project
    """

    def run(argv) do
        argv 
        |> parse_args
        |> process
    end

    @doc """
    'argv' can be -h or --help, which returns :help.

    Otherwise it is a github user name, project name, and (optionally)
    the number of entries to format.

    Return a tuple of '{ user, project, count }', or ':hellp' if help was given.
    """
    def parse_args(argv) do
        parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                         aliases: [ h: :help])

        case parse do
            { [ help: true ], _, _} -> :help
            { _, [ user, project, count ], _} -> { user, project, String.to_integer(count) }
            { _, [ user, project ], _ } -> { user, project, @default_count }
            _ -> :help
        end
    end

    def process(:help) do
        IO.puts """
        usage: issues <user> <project> [ count | #{@default_count} ]
        """
        System.halt(0)
    end

    def process({user, project, count}) do
        Issues.GithubIssues.fetch(user, project)
        |> decode_response
        |> convert_to_list_of_maps
        |> sort_ascending_by_created_at
        |> Enum.take(count)
        #|> print_table
        |> print_table_for_columns(["created_at", "number", "title"])
    end

    def decode_response({:ok, body}) do
        body
    end

    def decode_response({:error, body}) do
        {_, message} = List.keyfind("error", "message", 0)
        IO.puts "Error fetching from Github: #{message}"
        System.halt(2)
    end

    def convert_to_list_of_maps(list) do
        list
        |> Enum.map(&Enum.into(&1, Map.new))
    end

    def sort_ascending_by_created_at(list_of_issues) do
        Enum.sort(list_of_issues, &(&1["created_at"] <= &2["created_at"]))
    end

    def print_table_for_columns(issues, headers) do
        data_by_columns = data_by_columns(issues, headers)
        widths = widths_of(data_by_columns)
        row_format = format_for(widths)
        puts_one_line_columns(headers, row_format)
        IO.puts(separator(widths))
        puts_in_columns(data_by_columns, row_format)
    end

    def data_by_columns(rows, headers) do
        for header <- headers do
            for row <- rows do
                printable(row[header])
            end
        end
    end

    def printable(str) when is_binary(str) do
        str
    end
    
    def printable(str) do
        to_string(str)
    end

    def widths_of(columns) do
        for column <- columns do
            column
            |> Enum.map(&String.length/1)
            |> Enum.max
        end
    end

    def format_for(column_widths) do
        Enum.map_join(column_widths, " | ", &("~-#{&1}s")) <> "~n"
    end

    def separator(column_widths) do
        Enum.map_join(column_widths, "-+-", &(List.duplicate("-", &1)))
    end

    def puts_in_columns(data_by_columns, format) do
        data_by_columns
        |> List.zip
        |> Enum.map(&Tuple.to_list/1)
        |> Enum.each(&puts_one_line_columns(&1, format))
    end

    def puts_one_line_columns(fields, format) do
        :io.format(format, fields)
    end
end