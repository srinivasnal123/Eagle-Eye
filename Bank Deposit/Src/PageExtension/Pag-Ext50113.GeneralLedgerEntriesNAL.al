pageextension 50113 "General Ledge Entries NAL" extends "General Ledger Entries"
{
    layout
    {
        addafter("Source Code")
        {
            field("Description 2 NAL"; Rec."Description 2 NAL")
            {
                ApplicationArea = All;
            }
        }
    }
}
