// RS -  BC Go-live Tool v.2.0.0.6 - 20180915
// Based on Original release of Olof Simren -  Go-Live Tool, Range 50101..
page 50101 "Record Deletion"
{
    // version BCGOLIVE
    InsertAllowed = True; //Add records
    PageType = List;
    Editable = True;
    SourceTable = "Record Deletion Table";
    UsageCategory = Tasks;  //show in the Search Menù - "Record Deletion page"

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; "Table ID")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Delete Records")
                {
                    Caption = 'Delete Records';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        RecordDeletionMgt: Codeunit "Record Deletion Mgt.";
                    begin
                        RecordDeletionMgt.DeleteRecords; //DELETE RECORDS
                    end;
                }
            }
        }
    }
}

table 50101 "Record Deletion Table"
{
    // version BCGOLIVE
    fields
    {
        field(1; "Table ID"; Integer)
        {
            Editable = true;  //INSERT TABLE No.
        }
        field(5; "Delete Records"; Boolean)
        {
        }
        field(6; Company; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Table ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Company := CompanyName;
    end;
}

codeunit 50101 "Record Deletion Mgt."
{
    // version BCGOLIVE  
    trigger OnRun()
    begin
    end;

    var
        Text0001: Label 'Delete Records?';
        Text0002: Label 'Deleting Records!\Table: #1#######';

    procedure DeleteRecords()
    var
        Window: Dialog;
        RecRef: RecordRef;
        RecordDeletionTable: Record "Record Deletion Table";
    begin
        if not Confirm(Text0001, false) then
            exit;

        Window.Open(Text0002);

        if RecordDeletionTable.FindSet then
            repeat
                Window.Update(1, Format(RecordDeletionTable."Table ID"));
                RecRef.Open(RecordDeletionTable."Table ID");
                RecRef.DeleteAll;  //** DELETE DATA FROM TABLES
                RecRef.Close;
            until RecordDeletionTable.Next = 0;

        Window.Close;
    end;
}