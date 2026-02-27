reportextension 50100 "Bank Deposit NAL" extends "Bank Deposit"
{
    dataset
    {
        add("Posted Bank Deposit Line")
        {
            column(ExternalDocumentNo; "External Document No.")
            {
            }
        }
    }
}