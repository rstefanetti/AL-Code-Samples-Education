
Bubble Sort

    procedure BubbleSort(List: List of [Integer])
    var
        i, j : Integer;
        ListItem: Integer;
    begin
        for i := 1 to List.Count do begin
            for j := 1 to List.Count - 1 do begin
                if List.Get(i) < List.Get(j) then begin
                    ListItem := List.Get(i);
                    List.Set(i, List.Get(j));
                    List.Set(j, ListItem);
                end;
            end;
        end;
    end;


Merge Sort
    procedure MergeSort(List: List of [Integer])
    begin
        MergeSort(List, 1, List.Count);
    end;

    local procedure Merge(List: List of [Integer]; Left: Integer; Middle: Integer; Right: Integer)
    var
        i, j, k : Integer;
        LeftList: List of [Integer];
        RightList: List of [Integer];
    begin
        for i := Left to Middle do begin
            LeftList.Add(List.Get(i));
        end;
        for i := Middle + 1 to Right do begin
            RightList.Add(List.Get(i));
        end;

        i := 1;
        j := 1;
        k := Left;

        while (i <= LeftList.Count) and (j <= RightList.Count) do begin
            if LeftList.Get(i) <= RightList.Get(j) then begin
                List.Set(k, LeftList.Get(i));
                i := i + 1;
            end else begin
                List.Set(k, RightList.Get(j));
                j := j + 1;
            end;
            k := k + 1;
        end;

        while i <= LeftList.Count do begin
            List.Set(k, LeftList.Get(i));
            i := i + 1;
            k := k + 1;
        end;

        while j <= RightList.Count do begin
            List.Set(k, RightList.Get(j));
            j := j + 1;
            k := k + 1;
        end;
    end;

    local procedure MergeSort(List: List of [Integer]; Left: Integer; Right: Integer)
    var
        Middle: Integer;
    begin
        if Left < Right then begin
            Middle := (Left + Right) div 2;
            MergeSort(List, Left, Middle);
            MergeSort(List, Middle + 1, Right);
            Merge(List, Left, Middle, Right);
        end;
    end;



Quick Sort

 procedure QuickSort(List: List of [Integer])
    var
        i: Integer;
    begin
        QuickSort(List, 1, List.Count);
    end;

    local procedure Partition(List: List of [Integer]; Left: Integer; Right: Integer): Integer
    var
        i, j : Integer;
        Pivot: Integer;
    begin
        Pivot := List.Get(Right);
        i := Left - 1;
        for j := Left to Right - 1 do begin
            if List.Get(j) <= Pivot then begin
                i := i + 1;
                Swap(List, i, j);
            end;
        end;
        Swap(List, i + 1, Right);
        exit(i + 1);
    end;

    local procedure QuickSort(List: List of [Integer]; Left: Integer; Right: Integer)
    var
        Pivot: Integer;
    begin
        if Left < Right then begin
            Pivot := Partition(List, Left, Right);
            QuickSort(List, Left, Pivot - 1);
            QuickSort(List, Pivot + 1, Right);
        end;
    end;

    local procedure Swap(List: List of [Integer]; i: Integer; j: Integer)
    var
        ListItem: Integer;
    begin
        ListItem := List.Get(i);
        List.Set(i, List.Get(j));
        List.Set(j, ListItem);

    end;

