pageextension 50113 GLEntriesNAL extends "General Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2 NAL"; Rec."Description 2 NAL")
            {
                ApplicationArea = All;
            }
            field("EE FleetRock ID NAL"; Rec."EE FleetRock ID NAL")
            {
                ApplicationArea = all;
            }
        }
    }
}
