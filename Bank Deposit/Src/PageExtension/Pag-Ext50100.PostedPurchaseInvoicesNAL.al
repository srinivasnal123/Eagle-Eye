pageextension 50100 "Posted Purchase Invoices NAL" extends "Posted Purchase Invoices"
{
    layout
    {
        addbefore("Vendor Invoice No.")
        {
            field("Load Number NAL"; Rec."Load Number NAL")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the load number associated with this purchase invoice.';
            }
            field("Pre-Assigned No"; Rec."Pre-Assigned No.")
            {
                ApplicationArea = All;
            }
        }
    }
}