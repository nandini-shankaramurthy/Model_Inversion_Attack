//IMPORT ML_Core.Discretize;
IMPORT LearningTrees AS LT;
IMPORT ML_Core;
IMPORT $;

//Training and Test data
XTrain := $.Convert.myIndTrainDataANF;
YTrain := $.MyPredict;

XTest  := $.Convert.myIndTestDataANF;
YTest  := $.Convert.myDepTestDataANF;
//DTrain := Discretize.ByRounding(YTrain);

myLearnerC := LT.ClassificationForest();

myModelC := myLearnerC.GetModel(XTrain, YTrain); 

predictedClasses := myLearnerC.Classify(myModelC, XTest);

assessmentA := ML_Core.Analysis.Classification.Accuracy(predictedClasses, YTest);

assessmentC := ML_Core.Analysis.Classification.ConfusionMatrix(predictedClasses, YTest);

OUTPUT(assessmentC, NAMED('ConfusionMatrix'), ALL);
OUTPUT(assessmentA, NAMED('Accuracy'), ALL);

//OUTPUT($.loan.file);
//OUTPUT($.prep.myDataE);
//COUNT($.prep.myDataE)