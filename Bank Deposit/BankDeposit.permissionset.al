permissionset 50102 "Bank Deposit"
{
    Assignable = true;
    Permissions = codeunit "Import Purchase Invoices NAL" = X,
        codeunit UpdateLoadNoNAL = X,
        codeunit GLEntrySubscriberNAL = X,
        codeunit UpdateGLEntriesNAL = X,
        report "Update Load No NAL" = X,
        codeunit "Purch Line Desc. 2 Mgmt NAL" = X,
        codeunit "Sales Line Desc. 2 Mgmt NAL" = X;
}