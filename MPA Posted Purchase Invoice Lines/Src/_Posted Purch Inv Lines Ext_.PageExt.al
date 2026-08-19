pageextension 50149 "Posted Purch Inv Lines Ext" extends "Posted Purchase Invoice Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
                Caption = 'Posting Date';
            }
            field("Trip No."; Rec."Trip No.")
            {
                ApplicationArea = All;
                Caption = 'Trip No.';
                ToolTip = 'Specifies the trip number for this posted purchase invoice line.';
            }
        }
    }
}
