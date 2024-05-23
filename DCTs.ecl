EXPORT DCTs := MODULE 

    EXPORT Ls_DS := DATASET([
        {'Fully Paid',1},
        {'Current',2},
        {'Charged Off',3}
    ], {string loan_status, UNSIGNED1 lscode});

EXPORT LsDCT := DICTIONARY(Ls_DS, {Loan_status => lscode});

EXPORT MapLs2Code(String Loan_status) := lsDCT[Loan_status].lscode;

END;


