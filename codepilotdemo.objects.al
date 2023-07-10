codeunit 54001 MyCopilotCodeunitDemo1
{
    trigger OnRun()
    begin

    end;


    // TEST COPILOT
    local procedure MyItems()
    var
        item: Record Item;
        customer: Record customer;


    begin
        item.SetRange(Blocked, false);
        item.SetRange("No.", '1000');

        if item.FindSet() then
            repeat
                if item.Description = 'Test' then
                    item.Description := 'Test 2';
                item.Modify();
            until item.Next() = 0;


    end;


    var
        myInt: Integer;


}

codeunit 54002 MyCopilotDemo2
{
    trigger OnRun()
    begin

    end;
}


page 54007 MyAPIPage
{

    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = Item;
    PageType = API;
    APIPublisher = 'RS';
    APIGroup = 'item';
    EntityName = 'item';
    EntitySetName = 'item';
    DelayedInsert = True;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("No"; rec."No.")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateItem)
            {
                ApplicationArea = All;
                Caption = 'Update Item';
                //Promoted = true;
                //PromotedCategory = Update;
                Image = Update;

                trigger OnAction()
                begin
                    // UpdateItem(rec);
                end;
            }
        }
    }

}


report 54304 MyReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = mylayout; //Bottom

    dataset
    {
        dataitem(Item; Item)
        {
            column(No_; "No.")
            {

            }

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; CompanyName)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    rendering
    {
        layout(mylayout)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }

    var
        myInt: Integer;
}



