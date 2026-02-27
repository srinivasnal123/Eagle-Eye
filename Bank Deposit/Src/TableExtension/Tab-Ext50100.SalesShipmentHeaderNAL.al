tableextension 50100 "Sales Shipment Header NAL" extends "Sales Shipment Header"
{
    fields
    {
        field(50100; "Invoice No. NAL"; Code[20])
        {
            Caption = 'Invoice No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."No." where("Order No." = filter(<> ''), "Order No." = field("Order No.")));
            Editable = false;
        }
    }
}
