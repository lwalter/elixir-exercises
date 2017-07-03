defmodule CliTest do
    use ExUnit.Case

    import Issues.CLI, only: [ parse_args: 1 ]

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
end