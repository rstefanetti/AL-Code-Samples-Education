page 50005 "DMT - XML Runner LOG"
{
    // XML RUNNER LOG
    InsertAllowed = True; //add records
    PageType = List;
    Editable = True;
    SourceTable = "DTM - XML Runner LOG Table";
    UsageCategory = Tasks;  //show in the Search Menù - "Record Deletion page"
    //AccessByPermission = page "Record Deletion" = X;  //permissions for Page
    AccessByPermission = tabledata "DTM - XML Runner LOG Table" = RIMD; //ALL permissions for Table
    ApplicationArea = All;
    Caption = 'DMT - XML Runner LOG';

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("KeyTbl"; KeyTbl)
                {
                    Editable = true;
                    ApplicationArea = All;
                    Caption = 'KeyTbl';
                }
                field("Table ID"; "Table ID")
                {
                    Editable = true;
                    ApplicationArea = All;
                    Caption = 'table ID';
                }
                field("Migration Text"; "Migration Text")
                {
                    Editable = true;
                    ApplicationArea = All;
                    Caption = 'Migration TEXT';
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}