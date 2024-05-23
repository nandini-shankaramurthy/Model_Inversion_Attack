IMPORT LearningTrees AS LT;
IMPORT ML_Core;
IMPORT STD;
IMPORT $;

//Training and Test data
XTrain := $.Convert.myIndTrainDataNF;
YTrain := $.Convert.myDepTrainDataNF;
XTest  := $.Convert.myIndTestDataNF;
YTest  := $.Convert.myDepTestDataNF;
//DTrain := Discretize.ByRounding(YTrain);

myLearnerC := LT.ClassificationForest();

myModelC := myLearnerC.GetModel(XTrain, YTrain); // Notice second param uses the DiscreteField dataset

//EXPORT MyPredict := myLearnerC.Classify(myModelC, XTest);

predictedClasses := myLearnerC.Classify(myModelC, XTest);

SortedPredictions := SORT(predictedClasses, id);

output(SortedPredictions);

NumRecords := COUNT(SortedPredictions);
Top30PctCount := ROUNDUP(0.3 * NumRecords);


prevention := PROJECT(SortedPredictions, 
                      TRANSFORM(RECORDOF(SortedPredictions),
                                SELF.wi := LEFT.wi,
                                SELF.id := LEFT.id,
                                SELF.number := LEFT.number,
                                SELF.value := IF(COUNTER <= Top30PctCount, 
                                                 1 + (RANDOM()%3), 
                                                 LEFT.value)));

OUTPUT(prevention);                                      
//assessmentC := ML_Core.Analysis.Classification.ConfusionMatrix(Prevention, YTest);
//assessmentA := ML_Core.Analysis.Classification.Accuracy(Prevention, YTest);

//OUTPUT(assessmentC, NAMED('ConfusionMatrix'), ALL);
//OUTPUT(assessmentA, NAMED('Accuracy'), ALL);
