IMPORT $;
IMPORT ML_Core;

myTrainData := $.prep.myTrainData;
myTestData := $.prep.myTestData;
myTrainAData := $.prep.myDataBuild;
myTestAData := $.prep.myTestDataattack;

ML_Core.ToField(myTrainData, myTrainDataNF);
ML_Core.ToField(myTestData, myTestDataNF);
ML_Core.ToField(myTrainAData, myTrainDataANF);
ML_Core.ToField(myTestAData, myTestDataANF);

EXPORT Convert :=  MODULE
  EXPORT myIndTrainDataNF := myTrainDataNF(number < 14); //independent
  EXPORT myDepTrainDataNF := PROJECT(myTrainDataNF(number = 14), 
                                     TRANSFORM(ML_Core.Types.DiscreteField, 
                                               SELF.number := 1,
                                               SELF := LEFT)); // dependent 
  EXPORT myIndTestDataNF := myTestDataNF(number < 14); // Number is the field number
  EXPORT myDepTestDataNF := PROJECT(myTestDataNF(number = 14), 
                                    TRANSFORM(ML_Core.Types.DiscreteField, 
                                              SELF.number := 1,
                                              SELF := LEFT));

  EXPORT myIndTrainDataANF := myTrainDataANF(number < 14); // Number is the field number
  EXPORT myDepTrainDataANF := PROJECT(myTrainDataANF(number = 14), 
                                    TRANSFORM(ML_Core.Types.DiscreteField, 
                                              SELF.number := 1,
                                              SELF := LEFT));
  EXPORT myIndTestDataANF := myTestDataANF(number < 14); // Number is the field number
  EXPORT myDepTestDataANF := PROJECT(myTestDataANF(number = 14), 
                                    TRANSFORM(ML_Core.Types.DiscreteField, 
                                              SELF.number := 1,
                                              SELF := LEFT));
END;



