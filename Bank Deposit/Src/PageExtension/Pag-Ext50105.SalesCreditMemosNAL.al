pageextension 50105 "Sales Credit Memos NAL" extends "Sales Credit Memos"
{
    layout
    {
        addafter("Location Code")
        {
            field("EE Load Number"; Rec."EE Load Number")
            {
                ApplicationArea = All;
            }
        }
    }
}
