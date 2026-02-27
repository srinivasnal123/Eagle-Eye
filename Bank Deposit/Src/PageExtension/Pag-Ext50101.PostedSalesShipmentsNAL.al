pageextension 50101 "Posted Sales Shipments NAL" extends "Posted Sales Shipments"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Invoice No. NAL"; Rec."Invoice No. NAL")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoice No. field.';
            }
        }
    }
}
