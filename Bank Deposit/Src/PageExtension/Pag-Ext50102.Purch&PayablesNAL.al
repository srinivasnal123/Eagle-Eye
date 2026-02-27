pageextension 50102 "Purchase Setup NAL" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Vendor No. NAL"; Rec."Vendor No. NAL")
            {
                ApplicationArea = ALL;
            }
            field("G/L Account No. NAL"; Rec."G/L Account No. NAL")
            {
                ApplicationArea = All;
            }
        }
    }

}