pageextension 50144 "MPA Posted Purch Inv Subform" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Trip No."; Rec."Trip No.")
            {
                ApplicationArea = All;
                Caption = 'Trip No.';
                ToolTip = 'Specifies the trip number for this posted purchase invoice line.';
            }
        }
    }
}
