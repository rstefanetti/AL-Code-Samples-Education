page 50185 "Session List Custom"
{
    Caption = 'Kill Session';
    PageType = List;
    SourceTable = "Session";
    UsageCategory = Lists;
    ApplicationArea = All;
    Permissions = TableData "Session" = rimd;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Connection ID"; "Connection ID")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field("My Session"; "My Session")
                {
                    ApplicationArea = All;
                }
                field("Login Time"; "Login Time")
                {
                    ApplicationArea = All;
                }
                field("Login Date"; "Login Date")
                {
                    ApplicationArea = All;
                }
                field("Database Name"; "Database Name")
                {
                    ApplicationArea = All;
                }
                field("Application Name"; "Application Name")
                {
                    ApplicationArea = All;
                }
                field("Login Type"; "Login Type")
                {
                    ApplicationArea = All;
                }
                field("Host Name"; "Host Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
