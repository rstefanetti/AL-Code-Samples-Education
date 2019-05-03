page 50184 "Active Session List Custom"
{
    Caption = 'Kill Active Session';
    PageType = List;
    SourceTable = "Active Session";
    UsageCategory = Lists;
    ApplicationArea = All;
    Permissions = TableData "Active Session" = rimd;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User SID"; "User SID")
                {
                    ApplicationArea = All;
                }
                field("Server Instance ID"; "Server Instance ID")
                {
                    ApplicationArea = All;
                }
                field("Session ID"; "Session ID")
                {
                    ApplicationArea = All;
                }
                field("Server Instance Name"; "Server Instance Name")
                {
                    ApplicationArea = All;
                }
                field("Server Computer Name"; "Server Computer Name")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field("Client Type"; "Client Type")
                {
                    ApplicationArea = All;
                }
                field("Client Computer Name"; "Client Computer Name")
                {
                    ApplicationArea = All;
                }
                field("Login Datetime"; "Login Datetime")
                {
                    ApplicationArea = All;
                }
                field("Database Name"; "Database Name")
                {
                    ApplicationArea = All;
                }
                field("Session Unique ID"; "Session Unique ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
