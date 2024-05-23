//IMPORT ML_Core.Discretize;
IMPORT LearningTrees AS LT;
IMPORT ML_Core;
IMPORT STD;
IMPORT $;

//Training and Test data
// train data for original model
XTrain := $.Convert.myIndTrainDataNF; //features
YTrain := $.Convert.myDepTrainDataNF; //labels

//test data for original model
XTest  := $.Convert.myIndTestDataNF; //features
YTest  := $.Convert.myDepTestDataNF; //labels

//query data for original model
XQuery := $.Convert.myIndTrainDataANF;
YQuery := $.Convert.myDepTrainDataANF;

myLearnerC := LT.ClassificationForest();

myModelC := myLearnerC.GetModel(XTrain, YTrain); //train the model using training data, here we need to give both dependent and independent features

predictedClasses := myLearnerC.Classify(myModelC, XTest); // test the model

// query the model using a query dataset
EXPORT MyPredict := myLearnerC.Classify(myModelC, XQuery);

//assessmentC := ML_Core.Analysis.Classification.ConfusionMatrix(predictedClasses, YTest);
//assessmentA := ML_Core.Analysis.Classification.Accuracy(predictedClasses, YTest);

//OUTPUT(assessmentC, NAMED('ConfusionMatrix'), ALL);
//OUTPUT(assessmentA, NAMED('Accuracy'), ALL);