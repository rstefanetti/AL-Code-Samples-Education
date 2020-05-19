page 50001 "DMT - Delete Data from Tables"
{
    // DELETE DATA
    InsertAllowed = True; //Add records
    PageType = List;
    Editable = True;
    SourceTable = "DTM - Record Deletion Table";
    UsageCategory = Tasks;  //show in the Search Menù - "Record Deletion page"
    //AccessByPermission = page "Record Deletion" = X;  //permissions for Page
    AccessByPermission = tabledata "DTM - Record Deletion Table" = RIMD; //ALL permissions for Table
    ApplicationArea = All;
    Caption = 'DMT - Delete Data from Tables';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = All;
                    Caption = 'Table ID';
                    ToolTip = 'Insert Table Nr. to Delete';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("START DELETE RECORDS")
            {
                Caption = 'START DELETE RECORDS';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecordDeletionMgt: Codeunit "DTM - Management";
                begin
                    RecordDeletionMgt.DeleteRecords; //START DELETE RECORDS
                end;

            }
        }
    }
}
