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