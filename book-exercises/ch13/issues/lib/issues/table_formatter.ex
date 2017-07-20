defmodule Issues.TableFormatter do
    @moduledoc """
    Formatting and printing functions for GitHub issue input data.
    """

    @doc """
    Takes a list of row data, where each row is a Map, and a list of headers.
    Print a table to stdout of the data from each row identified by each
    header. That is, each header identifies a column, and those columns are
    extracted and printed from the rows.
    """
    def print_table_for_columns(issues, headers) do
        data_by_columns = data_by_columns(issues, headers)
        widths = widths_of(data_by_columns)
        row_format = format_for(widths)
        puts_one_line_columns(headers, row_format)
        IO.puts(separator(widths))
        puts_in_columns(data_by_columns, row_format)
    end

    @doc """
    Given a list of rows, where each row contains a keyed list of columns,
    return a list containing lists of the data in each column. The 'headers'
    parameter contains the list of columns to extract.

    ## Example
        iex> list = [Enum.into([{"a", "1"},{"b", "2"},{"c", "3"}], Map.new),
        ...>         Enum.into([{"a", "4"},{"b", "5"},{"c", "6"}], Map.new)]
        iex> Issues.TableFormatter.data_by_columns(list, ["a", "b", "c"])
        [["1", "4"],["2", "5"],["3", "6"]]
    """
    def data_by_columns(rows, headers) do
        for header <- headers do
            for row <- rows do
                printable(row[header])
            end
        end
    end

    @doc """
    Return a binary (string) version of our parameter.
    ## Examples
        iex> Issues.TableFormatter.printable("a")
        "a"
        iex> Issues.TableFormatter.printable(99)
        "99"
    """
    def printable(str) when is_binary(str) do
        str
    end
    def printable(str) do
        to_string(str)
    end

    @doc """
    Given a list containing sublists, where each sublist contains the data
    for a column, return a list containing the maximum width of each column.

    ## Example
        iex> data = [["cat", "wombat", "elk"], ["mongoose", "ant", "gnu"]]
        iex> Issues.TableFormatter.widths_of(data)
        [6, 8]
    """
    def widths_of(columns) do
        for column <- columns do
            column
            |> Enum.map(&String.length/1)
            |> Enum.max
        end
    end

    @doc """
    Return a format string that hard codes the widths of a set of columns.
    Each column is separated by `" | "`.

    ## Example
        iex> widths = [1, 5, 99]
        iex> Issues.TableFormatter.format_for(widths)
        "~-1s | ~-5s | ~-99s~n"
    """
    def format_for(column_widths) do
        Enum.map_join(column_widths, " | ", &("~-#{&1}s")) <> "~n"
    end

    @doc """
    Return a line that is placed below the column headings. It is a
    string of hyphens, with + signs where the vertical bar between
    the columns goes.

    ## Example
        iex> widths = [2,5,7]
        iex> Issues.TableFormatter.separator(widths)
        "---+-------+--------"
    """
    def separator(column_widths) do
        Enum.map_join(column_widths, "-+-", &(List.duplicate("-", &1)))
    end

    @doc """
    Given a list containing rows of data, a list containing header
    selectors, and a format string, wite the extracted data under
    control of the format string.
    """
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
