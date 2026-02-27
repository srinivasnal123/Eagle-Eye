pageextension 50112 "Posted Sales Invoices NAL" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Pre-Assigned No.")
        {
            field("EE Load Number2"; Rec."EE Load Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the EagleEye Load Number associated with this sales invoice.';
            }
        }
    }
}