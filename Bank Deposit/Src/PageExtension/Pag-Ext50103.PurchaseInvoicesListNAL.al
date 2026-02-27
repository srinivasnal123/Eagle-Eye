pageextension 50103 "Purchase Invoices NAL" extends "Purchase Invoices"
{
    actions
    {
        addafter(Vendor)
        {
            action(ImportInvoices)
            {
                Caption = 'Import Purchase Invoices';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ImpPurchInv: Codeunit "Import Purchase Invoices NAL";
                begin
                    ImpPurchInv.ReadExcelSheet();
                    ImpPurchInv.ImportExcelData();
                end;
            }
        }
    }


}