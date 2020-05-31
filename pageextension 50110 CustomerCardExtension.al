pageextension 50110 CustomerCardExtension extends “Customer Card”

{

layout

{

addlast(General)

{

// control with underlying datasource

field(“Shoe Size”; ShoeSize)

{

ApplicationArea = All;

Caption = ‘ShoeSize’;

trigger OnValidate();

begin

if ShoeSize < 10 then

Error(‘Feet too small’);

end;

}

// display-only control (without underlying datasource)

field(ShoesInStock; 10)

{

ApplicationArea = All;

Caption = ‘Shoes in stock’;

}

}

modify(“Address 2”)

{

Caption = ‘New Address 2’;

}

}