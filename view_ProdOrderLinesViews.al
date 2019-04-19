//#1 - CREATE A NEW PRIFILE mapped to ROLE CENTER - duplicated from "Production Planner Role Center" in this case
profile CUSTOMPRODUCTION
{
    Description = 'CUSTOMPRODUCTION';
    RoleCenter = "Production Planner Role Center";    //New Profile
    Customizations = ViewProdLineViews;
}


//#2 - CREATE A NEW PAGE (BASE FO VIEWS) - Only List Pages are used in Views
page 50205 CustProdOrderLine
{
    PageType = List;   //Only list
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Prod. Order Line";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Caption = 'CustProdOrderLine';
    //Permissions = TableData "Prod. Order Line"=rimd;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Prod. Order No."; "Prod. Order No.")
                {
                    ApplicationArea = All;

                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;

                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;

                }

                field("Finished Quantity"; "Finished Quantity")
                {
                    ApplicationArea = All;

                }
                field("Remaining Quantity"; "Remaining Quantity")
                {
                    ApplicationArea = All;

                }
                field("Unit Cost"; "Unit Cost")
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                end;
            }
        }
    }

    var
        myInt: Integer;
}


//#3 - CREATE VIEWS based on "ProdOrderLine" List Pages (two in this sample)
pagecustomization ViewProdLineViews customizes "CustProdOrderLine"
//Customize and put the Views in Customizations List
{
    views
    {
        addfirst
        {
            view(ProductionOrdersCompleted) //Prod order completed            
            {
                Caption = 'Production Order Completed';
                Filters = WHERE ("Remaining Quantity" = filter (0));  //only completed lines
                Layout
                {
                }

            }

            view(ProductionOrdersOpen)  //Prod order opened
            {
                Caption = 'Production Order Open';
                Filters = WHERE ("Remaining Quantity" = filter (> 0));  //only opened lines
                Layout
                {
                }
            }
        }
    }

}
