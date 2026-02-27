reportextension 60803 "CV Remittance Advice Jnl" extends "Remittance Advice - Journal"
{
    dataset
    {
        add(VendLoop)
        {
            column(RemitTo; RemitTo.Code)
            {
            }
            column(RemitAddr1; RemitAddr[1])
            {
            }
            column(RemitAddr2; RemitAddr[2])
            {
            }
            column(RemitAddr3; RemitAddr[3])
            {
            }
            column(RemitAddr4; RemitAddr[4])
            {
            }
            column(RemitAddr5; RemitAddr[5])
            {
            }
            column(RemitAddr6; RemitAddr[6])
            {
            }
            column(RemitAddr7; RemitAddr[7])
            {
            }
            column(RemitAddr8; RemitAddr[8])
            {
            }
        }
        modify("Gen. Journal Line")
        {
        trigger OnAfterAfterGetRecord()
        var
            Vendor: Record Vendor;
            FormatAddr: Codeunit "Format Address";
        begin
            Clear(RemitAddr);
            Clear(RemitTo);
            if("Gen. Journal Line"."Remit-to Code" <> '') and ("Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::Vendor)then begin
                RemitTo.Get("Gen. Journal Line"."Remit-to Code", "Gen. Journal Line"."Account No.");
                FormatAddr.VendorRemitToAddress(RemitTo, RemitAddr);
            end
            else if "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::Vendor then begin
                    Vendor.Get("Account No.");
                    FormatAddr.Vendor(RemitAddr, Vendor);
                end;
        end;
        }
    }
    requestpage
    {
    // Add changes to the requestpage here
    }
    rendering
    {
    }
    var RemitTo: Record "Remit Address";
    RemitAddr: array[8]of Text[100];
}
