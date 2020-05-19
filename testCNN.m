function testAlexNetCNN(var)
% The trained model from alexnetCNN.m (script) is loaded to be used here
% Detecting Multiples Boxes and Extracting boundingBox is from Lecture 7 Labs.
load('alexCNNModel.mat')
% Retrieves the image file to classify using the model
I = imread(var);
FaceDetector = vision.CascadeObjectDetector();
shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[0 255 255]);
bbox = step(FaceDetector, I);

% Checks if the Bounding Box has detected any faces
if ~isempty(bbox)
    
    %Bounding box isn't empty, retrieves the amount of bounding boxes, this
    %is suggested to be equal to the amount of faces detected
    N = size(bbox, 1);
    P = [];
    for i=1:N
        %For every Face detected, this script takes in the dimensions of
        %the bounding box
        % Extract ith face
        a = bbox(i, 1);
        b = bbox(i, 2);
        c = a+bbox(i, 3);
        d = b+bbox(i, 4);
        F = I(b:d, a:c, :);
        
        % For every face, crop the face out
        J=imcrop(I,bbox(i,:));
        % Resize it to the size required by CNN. CNN requires at least
        % 227x227 for the first layers
        newImageSize = imresize(J, [227, 227]);
        % Use saved model to predict classify the image to a specific student
        predict = classify(alexCNNModel,newImageSize);
        % Using the dimensions and the predicted value, this is written in
        % the cropped face
        RBG = insertText(F,[0,50],char(predict),'FontSize', 30, 'BoxColor', 'white','AnchorPoint','LeftBottom');
        %The cropped face alongside the inserted number then overwrites the
        %original image, so that the ID number of student is shown into the
        %original image and displayed
        I(b:d, a:c, :) = RBG;
        
        % Calculating the center of the face, X and Y values of each
        % bounding box from the TOP X and Left Y value of the image
        xValue = bbox(i,1);
        yValue = bbox(i,2);
        
        % The width of each bounding box and height
        width = bbox(i,3);
        height = bbox(i,4);
        
        %Calculation to find the center of the bounding box from the image.
        xCenter = xValue+(width/2);
        yCenter = yValue+(height/2);
        
        %Stores the classified/predicted value of the student, and the
        %center of their bounding box into a matrix
        values = [grp2idx(predict), xCenter, yCenter];
        P(end+1,:) = values;
        
    end
        P
    I_faces = step(shapeInserter, I, int32(bbox));
    figure
    imshow(I_faces);
else
    % No Face detected
    disp("No face detected");
end
end