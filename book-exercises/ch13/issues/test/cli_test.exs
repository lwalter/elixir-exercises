defmodule CliTest do
    use ExUnit.Case

    import Issues.CLI, only: [ parse_args: 1, sort_ascending_by_created_at: 1, convert_to_list_of_hashdicts: 1 ]

    test ":help returned by option parsing with -h and --help options" do
        assert parse_args(["-h", "anything"]) == :help
        assert parse_args(["--help", "anything"]) == :help
    end

    test "three values returned by option parsing when three given" do
        assert parse_args(["someuser", "someproject", "123"]) == {"someuser", "someproject", 123}
    end
    
    test "count is defaulted when none specified" do
        assert parse_args(["user1", "project1"]) == {"user1", "project1", 4}
    end

    test "elements are sorted in ascending order" do
        result = sort_ascending_by_created_at(fake_created_at_list(["3", "2", "1"]))
        issues = for issue <- result, do: issue["created_at"]
        assert issues == ~w{1 2 3}
    end
    
    defp fake_created_at_list(values) do
        data = for value <- values, do: [{"created_at", value}, {"other_data", "xxx"}]
        convert_to_list_of_maps(data)
    end
end