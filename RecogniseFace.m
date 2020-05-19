%Function that takes in Image, FeatureType and Classifer and returns the
%matrix and studentID, also shows the student


function  P = RecogniseFace(I, featureType, classifierType)

%Fixes the rotation of the image and overwrites it before using it
    fixRotation(I);
    
%Switch case to handle all the options and call the right functions
    switch classifierType
        case 'CNN'
            switch featureType
                case ""
                     disp("CNN is selected");
                      testCNN(I);
                otherwise 
                     disp("There is no featureType option in CNN");
                     disp("Leave featureType empty");
            end
        case 'SVM'
            switch featureType
                case 'HOG'
                    disp("HOG SVM is selected");
                    testHOG(I);                
                case 'SURF'
                    disp("SURF HOG is selected");
                    testSURF(I);   
                otherwise
                    disp("Invalid featureType");       
            end   
    end  
end
