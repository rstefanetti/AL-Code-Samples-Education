permissionsetextension 50140 "Extended Sales Doc" extends "Sales Person"
{​
    Permissions =​ tabledata Currency = ID;
}

permissionset 50134 "Sales Person"
{
    Assignable = true;
    Caption = 'Sales Person';

    Permissions = 
        tabledata Customer = RIMD,
        tabledata "Payment Terms" = RMD,
        tabledata Currency = RM,
        tabledata "Sales Header" = RIM,
        tabledata "Sales Line" = RIMD;
}


permissionset 50135 MyPermissionSet 
{ 
    Assignable = true;
    Caption = 'My PermissionSet';
    IncludedPermissionSets = "Sales Person"; 

    Permissions = 
        tabledata Vendor = RIm,
        codeunit SomeCode = x, 
        codeunit AccSchedManagement= X; 
}
