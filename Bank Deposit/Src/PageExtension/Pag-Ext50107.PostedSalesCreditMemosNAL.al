pageextension 50107 "Posted Sales Credit Memos NAL" extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Due Date")
        {
            field("Load No."; Rec."Load No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
