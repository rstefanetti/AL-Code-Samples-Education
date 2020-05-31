profile TheBoss

{

Description = ‘The Boss’;

RoleCenter = “Business Manager”;

Customizations = MyCustomization;

}



pagecustomization MyCustomization customizes “Customer List”

{

actions

{

moveafter(“Blanket Orders”; “Aged Accounts Receivable”)

modify(NewSalesBlanketOrder)

{

Visible = false;

}

}

}