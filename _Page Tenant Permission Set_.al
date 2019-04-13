page 50280 "Page Tenant Permission Set"
{
  PageType = List;
  SourceTable = "Tenant Permission Set";
  UsageCategory = Administration;
  ApplicationArea = All;
  Caption = 'Tenant Permission Set';
  Permissions = TableData "2000000165"=rimd;

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
        field("Name";"Name")
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
