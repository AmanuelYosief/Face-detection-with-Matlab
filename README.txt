Face Recognition using Matlab

1. Matlab has a prefence to output values in exponentials
hence run "format shortG" first. 

Arguements available to process:

2. To run any HOG/SURF with SVM classifier
RecogniseFace("I","SURF", "SVM")
or
RecogniseFace("I","HOG", "SVM")
where I is an image file. E.g. "1IMG_6820.png"

A complete arguement is RecogniseFace("1IMG_6820.png", "SURF", "SVM") or RecogniseFace("1IMG_6820.png", "HOG", "SVM")

To run a CNN model, the FeatureType is not necessary and thus is to be
left empty as "".
Hence. Acceptable arguements are 
RecogniseFace("1IMG_6820.png", "", "CNN")

IF you want to process an Image from a sub folder. 
Valid arguement is RecogniseFace("testset/01/1IMG_6820.png", "", "CNN")


The other functions and their usuage:

----Classifier scripts:

alexnetClassifier.m, hog.m, surf.m = where classifier (and featureTypes excluding CNN) 
are used to build, train a model and then save it locally. To Run these scripts, make sure to update the location of the dataset.

-- testCNN.m, testHOG.m, testSURF.m = where classifer (and featuresTypes excluding CNN) 
use models that were saved and uses them against new data. 

---
surfModel.mat, hogModel.mat, alexCNNModel.mat are all classifiers that are loaded at each query. Hence, expect a slight delay (especially for hog)





---Other scripts:

processFormats.m = the main script to handle all the processing, so that it is automated

cropFace.m = video and photo face cropping and saving into processedFaces folder.

toGray.m = converts all RBG images in /croppedFaces into grayscale and saves them in ProcessedFaces

fixRotation.m = fixes a recognized issue with different Matab/OS changing
photos in a different rotation when including it to the project.


---Others
Photos = pictures of individual students into their separate folders
processedFaces = cropped faces from Photos
grayFaces = gayscale of processedFaces


