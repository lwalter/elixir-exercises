defmodule TableFormatterTest do
    use ExUnit.Case
    import ExUnit.CaptureIO
    alias Issues.TableFormatter, as: TF

    def simple_test_data() do
        [ [c1: "r1 c1", c2: "r1 c2", c3: "r1 c3", c4: "r1+++c4"],
            [c1: "r2 c1", c2: "r2 c2", c3: "r2 c3", c4: "r2 c4"],
            [c1: "r3 c1", c2: "r3 c2", c3: "r3 c3", c4: "r3 c4"],
            [c1: "r4 c1", c2: "r4++c2", c3: "r4 c3", c4: "r4 c4"], ]
    end
    
    def headers() do
        [:c1, :c2, :c4]
    end

    def split_with_three_columns() do
        TF.data_by_columns(simple_test_data(), headers())
    end

    test "split_into_columns" do
        columns = split_with_three_columns()
        assert length(columns) == length(headers())
        assert List.first(columns) == ["r1 c1", "r2 c1", "r3 c1", "r4 c1"]
        assert List.last(columns) == ["r1+++c4", "r2 c4", "r3 c4", "r4 c4"]
    end

    test "widths_of" do
        columns = split_with_three_columns()
        widths = TF.widths_of(columns)
        assert widths == [5, 6, 7]
    end

    test "format_for" do
        format_string = TF.format_for([13, 56, 8])
        assert format_string == "~-13s | ~-56s | ~-8s~n"
    end

    test "separator" do
        separator_string = TF.separator([1, 5, 3])
        assert separator_string == "--+-------+----"
    end

    test "Output is correct" do
        result = capture_io(fn -> TF.print_table_for_columns(simple_test_data(), headers()) end)
        assert result == """
        c1    | c2     | c4     
        ------+--------+--------
        r1 c1 | r1 c2  | r1+++c4
        r2 c1 | r2 c2  | r2 c4  
        r3 c1 | r3 c2  | r3 c4  
        r4 c1 | r4++c2 | r4 c4  
        """
    end
end