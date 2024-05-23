IMPORT $;

loan := $.loan.file;

ML_Data := $.loan.MyData;

    EXPORT Prep := MODULE
    MLloan := RECORD(ML_data)
        UNSIGNED4 rnd; // A random number
    END;

    MLloan ML_Clean(loan le, INTEGER Cnt) := TRANSFORM
        SELF.rnd := RANDOM();
        SELF.RECID := Cnt;
        SELF.id := (UNSIGNED8)Le.id;
        SELF.loan_amnt := (DECIMAL)Le.loan_amnt;
        SELF.funded_amnt := (DECIMAL)Le.funded_amnt;
        SELF.int_rate := (DECIMAL)Le.int_rate;
        SELF.installment := (DECIMAL)Le.installment;
        SELF.annual_inc := (DECIMAL)Le.annual_inc;
        SELF.dti := (DECIMAL)Le.dti;
        SELF.open_acc := (UNSIGNED8)Le.open_acc;
        SELF.revol_bal := (DECIMAL)Le.revol_bal;
        SELF.revol_util := (DECIMAL)Le.revol_util;
        SELF.total_acc := (UNSIGNED8)Le.total_acc;
        SELF.total_rec_int := (DECIMAL)Le.total_rec_int;
        SELF.total_rec_late_fee := (DECIMAL)Le.total_rec_late_fee;
        SELF.loan_status := $.DCTs.MapLs2Code(Le.Loan_status);
        SELF := Le;
    END;
    
    EXPORT myDataE := PROJECT(loan, ML_Clean(LEFT,COUNTER));

    SHARED myDataES := SORT(myDataE, rnd);

    Clean := myDataES.id <> 0 AND myDataES.loan_amnt <> 0 AND myDataES.funded_amnt <> 0 AND myDataES.int_rate <> 0 AND myDataES.installment <> 0 AND myDataES.annual_inc <> 0 AND myDataES.dti <> 0 AND myDataES.open_acc <> 0 AND myDataES.revol_bal <> 0 AND myDataES.revol_util <> 0 AND myDataES.total_acc <> 0  AND myDataES.total_rec_int <> 0 AND myDataES.total_rec_late_fee <> 0 AND myDataES.loan_status <> 0;

    export myDataEN := myDataES(clean);

    EXPORT myTrainData := PROJECT(myDataEN[1..2000], ML_data); // train data the original model

    EXPORT myTestData := PROJECT(myDataEN[2002..3000], ML_data); // test data the original model

    EXPORT myDataBuild := PROJECT(myDataEN[3001..4000], ML_data); // query original model and give as input to attack model

    EXPORT myTestDataattack := PROJECT(myDataEN[4001..5000], ML_data); // test data for attack model

END;


