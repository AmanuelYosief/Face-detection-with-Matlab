function  cropFace(foldername,var)

%% Used to crop faces from photos and videos and save them into the correct directory

%Filename and extension is passed on 
[filepath,name,ext] = fileparts(var);
disp(char([name,ext]));

% checks if its a video file
if ext == '.mp4'
    %% Read Video using VideoReader
    videoframe = VideoReader(var);
    img_id = 1;
    % Videoframe.NumFrames is the number of frames in a video, so for every
    % frame, a shot can be taken. This can be configured to take less
    % photos by dividing the numFrames number. 
    for idx = 1:1:videoframe.NumFrames 
        curframe = read(videoframe,idx);
       
        %% Face detection using CascadeObjectDetector
        FaceDetect = vision.CascadeObjectDetector;
        bbox = step(FaceDetect, curframe);
        
        if ~isempty(bbox)
            %% THERE IS FACE DETECTED
            for jdx = 1:size(bbox,1)
                rectangle('Position',bbox(jdx,:),'LineWidth',3,'LineStyle','-','EdgeColor','r');
            end
            %% crop faces
            for kdx = 1:size(bbox,1)
                Fimg = imcrop(curframe, bbox(kdx,:));
                newImageSize = imresize(Fimg, [256, 256]);
                %figure(3), subplot(2,2,kdx); imshow(Fimg);
                file_name = num2str(img_id);
                img_id = img_id+1;
                imwrite(newImageSize, ['processedFaces\', char(foldername), '\',file_name,  char([name,'.jpg'])], 'jpg');

            end
        else
            %% THERE IS NO FACE DETECTED
            disp("No faces detected in the video");
        end
        disp("Finished Video");
    end
elseif ext == ".JPG"
    I = imread(var);
    FaceDetect = vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[150,150]);
    bbox=step(FaceDetect,I);
    if ~isempty(bbox)
        for i=1:size(bbox,1)
            J=imcrop(I,bbox(i,:));
            newImageSize = imresize(J, [256, 256]);
            imwrite(newImageSize,['processedFaces\',char(foldername), '\', char([name,ext])]);
            %imwrite(img,['croppedfaces\', str,'\',int2str(j), '.jpg']);
            %figure;
            imshow(newImageSize);
        end
        disp("Finished Photo");
    else
        disp("No faces detected in the image");
    end
end