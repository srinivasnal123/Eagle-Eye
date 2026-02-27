permissionset 50102 "Bank Deposit"
{
    Assignable = true;
    Permissions = codeunit "Import Purchase Invoices NAL" = X,
        codeunit UpdateLoadNoNAL = X,
        report "Update Load No NAL" = X;
}