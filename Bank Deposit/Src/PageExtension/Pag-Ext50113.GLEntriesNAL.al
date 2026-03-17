pageextension 50113 GLEntriesNAL extends "General Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("EE FleetRock ID NAL"; Rec."EE FleetRock ID NAL")
            {
                ApplicationArea = all;
            }
        }
    }
}
