query 50121 “Item Attribute Value Mapping”
{
//version v.1.0 RS
elements
{
dataitem(Item;Item)
{
column(No_;”No.”)
{
}
column(Description;Description)
{
}
dataitem(Item_Attribute_Value_Mapping;”Item Attribute Value Mapping”)
{
DataItemLink = “No.”= Item.”No.”;
column(Table_ID; “Table ID”)
{
}
column(No;”No.”)
{
}
column(Item_Attribute_ID;”Item Attribute ID”)
{
}
column(Item_Attribute_Value_ID;”Item Attribute Value ID”)
{
}
dataitem(QueryElement6;”Item Attribute”)
{
DataItemLink = ID=Item_Attribute_Value_Mapping.”Item Attribute ID”;
column(Name;Name)
{
}
column(Type;Type)
{
}
column(Unit_of_Measure;”Unit of Measure”)
{
}
dataitem(QueryElement10;”Item Attribute Value”)
{
DataItemLink = “Attribute ID”=Item_Attribute_Value_Mapping.”Item Attribute ID”,
ID=Item_Attribute_Value_Mapping.”Item Attribute Value ID”;
column(Value;Value)
{
}
column(Numeric_Value;”Numeric Value”)
{
}
column(Date_Value;”Date Value”)
{
}
column(Blocked;Blocked)
{
}
}
}
}
}
}
}
