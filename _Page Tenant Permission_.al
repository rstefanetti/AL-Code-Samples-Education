page 50281 "Page Tenant Permission"
{
  PageType = List;
  SourceTable = "Tenant Permission";
  UsageCategory = Administration;
  ApplicationArea = All;
  Caption = 'Tenant Permission';
  Permissions = TableData "2000000166"=rimd;

  layout
  {
    area(content)
    {
      repeater(Group)
      {
        field("App ID";"App ID")
        {
          ApplicationArea = all;
        }
        field("Role ID";"Role ID")
        {
          ApplicationArea = all;
        }
        field("Role Name";"Role Name")
        {
          ApplicationArea = all;
        }
        field("Object Type";"Object Type")
        {
          ApplicationArea = all;
        }
        field("Object ID";"Object ID")
        {
          ApplicationArea = all;
        }
        field("Object Name";"Object Name")
        {
          ApplicationArea = all;
        }
        field("Read Permission";"Read Permission")
        {
          ApplicationArea = all;
        }
        field("Insert Permission";"Insert Permission")
        {
          ApplicationArea = all;
        }
        field("Modify Permission";"Modify Permission")
        {
          ApplicationArea = all;
        }
        field("Delete Permission";"Delete Permission")
        {
          ApplicationArea = all;
        }
        field("Execute Permission";"Execute Permission")
        {
          ApplicationArea = all;
        }
        field("Security Filter";"Security Filter")
        {
          ApplicationArea = all;
        }
      }
    }
  }
  actions
  {
  }
}
