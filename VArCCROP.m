function  VArCCROP(foldername,var)


% % [img,fileinfo] = readimage(ds1,1);
% [filepath,name,ext] = fileparts(fileinfo.Filename);
% disp(char([name,ext]))

[filepath,name,ext] = fileparts(var);
 disp(char([name,ext]));




I = imread(var);
FaceDetect = vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[150,150]);
bbox=step(FaceDetect,I);
if ~isempty(bbox)
    for i=1:size(bbox,1)
    J=imcrop(I,bbox(i,:));
        imwrite(J,['croppedfaces\',char(foldername), '\', char([name,ext])]);
    %imwrite(img,['croppedfaces\', str,'\',int2str(j), '.jpg']);
    %figure;
    %imshow(J);
    end
end
end
