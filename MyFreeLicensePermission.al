permissionset 50101 MyFreeLicensePermission
{
    Assignable = false;
    Permissions = table MyTable = X,
                  tabledata MyTable = R;
}

permissionset 50102 MyOfferLicensePermission
{
    Assignable = false;
    Permissions = tabledata MyTable = RMID;
    IncludedPermissionSets = "MyFreeLicensePermission";
}

entitlement BC_Unlicensed
{
    Type = Unlicensed;
    ObjectEntitlements = "MyFreeLicensePermission";
}

entitlement BC_PerUserOfferPlan
{
    Type = PerUserOfferPlan;
    Id = 'MyOfferPlan';
    ObjectEntitlements = "MyOfferLicensePermission";
}

...
procedure CheckingForEntitlementsUsingPermissions()
    var
        myTable: Record MyTable;
    begin
        if myTable.WritePermission() then
            message('User is entitled and has permission to write to MyTable => user is licensed')
        else
            if myTable.ReadPermission() then
                message('User is entitled and has permission to read from MyTable => user is unlicensed')
            else
                Message('User does not have permission to read from MyTable - we do not know if the user is licensed ');
    end;

    procedure CheckingForMyEntitlements()
    begin
        if NavApp.IsUnlicensed() then
            Message('User is assigned my BC_Unlicensed entitlement')
        else
            if NavApp.IsEntitled('BC_PerUserOfferPlan') then
                Message('User is assigned my BC_PerUserOfferPlan entitlement')
            else
                Message('This user is not assigned any of my entitlements, so this code will not run');
    end;

    procedure CheckingForOtherAppEntitlements()
    begin
        if (NavApp.IsEntitled('Delegated Admin agent - Partner', '63ca2fa4-4f03-4f2b-a480-172fef340d3f')) then
            Message('User is assigned the delegated admin agent entitlement defined in the system app: https://github.com/microsoft/BCApps/blob/main/src/System%20Application/App/Entitlements/DelegatedAdminagentPartner.Entitlement.al')
        else
            if (NavApp.IsEntitled('Dynamics 365 Business Central Essentials', '63ca2fa4-4f03-4f2b-a480-172fef340d3f')) then
                Message('User is assigned the essentials entitlement defined in the system app: https://github.com/microsoft/BCApps/blob/main/src/System%20Application/App/Entitlements/Dynamics365BusinessCentralEssentials.Entitlement.al');
    end;
...
