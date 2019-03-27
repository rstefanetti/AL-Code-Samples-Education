page 50197 "CountRecords"
{
    // RS v1.0- COUNT TABLES RECORDS
    PageType = ListPlus;
    Editable = True;
    UsageCategory = Lists;
    ApplicationArea = All;
    Caption = 'Count Tables Records';
    Permissions = tabledata "CountTablesRecords" = RIMD;
    SourceTable = 50197;

    layout
    {
        area(Content)
        {

            repeater(Group)
            {
                field(TableID; TableID)
                {
                    ApplicationArea = All;

                }
                field(TableDescr; TableDescr)
                {
                    ApplicationArea = All;

                }
                field(RecordCount; RecordCount)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(StartCountRecords)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CalcCountRecords()
                end;
            }
        }
    }

    var
        flagcount: Boolean;
        rec50197: Record 50197;               // MYTABLE
        rec2000000041: Record 2000000041;     // TABLE CAPTIONS - SYSTEM
        CountRecords: Integer;
        MyRecordRef: RecordRef;
        varTableNo: Integer;
        i: Integer;
        parTableNo: Integer;

    procedure CalcCountRecords()
    //CALC RECORD COUNT
    begin
        //# STEP1 - DELETE DATA
        rec50197.DELETEALL(true);
        Commit();
        i := 1;

        for i := 1 to 1253 DO BEGIN
            varTableNo := i;  //CURRENT TABLE         
            WriteData(varTableNo);
        end;

        i := 1280;
        for i := 1280 to 1900 DO BEGIN
            varTableNo := i;  //CURRENT TABLE         
            WriteData(varTableNo);
        end;

        i := 5050;
        for i := 5050 to 5328 DO BEGIN
            varTableNo := i;  //CURRENT TABLE         
            WriteData(varTableNo);
        end;

        i := 5401;
        for i := 5401 to 5433 DO BEGIN
            varTableNo := i;  //CURRENT TABLE         
            WriteData(varTableNo);
        end;

        i := 5475;
        for i := 5475 to 5722 DO BEGIN
            varTableNo := i;  //CURRENT TABLE         
            WriteData(varTableNo);
        end;

        i := 5740;
        for i := 5740 to 6670 DO BEGIN
            varTableNo := i;  //CURRENT TABLE         
            WriteData(varTableNo);
        end;

        i := 7000;
        for i := 7000 to 9999 DO BEGIN
            varTableNo := i;  //CURRENT TABLE         
            WriteData(varTableNo);
        end;

        i := 12000;
        for i := 12000 to 13000 DO BEGIN
            varTableNo := i;  //CURRENT TABLE         
            WriteData(varTableNo);
        end;

        i := 99000750;
        for i := 99000750 to 99000880 DO BEGIN
            varTableNo := i;  //CURRENT TABLE         
            WriteData(varTableNo);
        end;

        Message('Tables Records Calculated');

    END;

    procedure WriteData(parTableNo: integer)
    //WRITE DATA IN MY CUSTOM TABLE
    begin
        rec2000000041.RESET;
        rec2000000041.SetRange(TableNo, parTableNo);

        //TEST TABLE AND COUNT DATA           
        IF rec2000000041.FindFirst() THEN BEGIN
            MyRecordRef.OPEN(parTableNo);
            MyRecordRef.LOCKTABLE;
            CountRecords := 0;
            CountRecords := MyRecordRef.COUNT;

            //WRITE DATA IN MY CUSTOM TABLE
            IF MyRecordRef.COUNT > 0 THEN BEGIN
                rec50197.Init();
                rec50197.TableID := parTableNo;
                rec50197.TableDescr := MyRecordRef.NAME;
                rec50197.RecordCount := CountRecords;
                rec50197.Insert();
                Commit();
            END;
            MyRecordRef.CLOSE;
        end;
    END;
}

