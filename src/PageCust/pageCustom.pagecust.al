profile MyProfile
{
    Description = 'My Role Center';
    RoleCenter = "Order Processor Role Center";
    Customizations = MyCustomization1;
}

pagecustomization MyCustomization1 customizes 50094
{
    layout
    {
        // Change the layout of the page
    }

    actions
    {
        // Add any actions to the page
    }

    views
    {
        addfirst
        {
            view("ALL Used Objects")
            {
                Filters = where(Used = const(true));
                OrderBy = ascending("Object Type", "Object ID");
                SharedLayout = true;
                CaptionML = ENU = 'ALL Used Objects';
            }

            view("ALL Free Objects")
            {
                Filters = where(Used = const(false));
                OrderBy = ascending("Object Type", "Object ID");
                SharedLayout = true;
                CaptionML = ENU = 'ALL Free Objects';
            }
        }
    }

}