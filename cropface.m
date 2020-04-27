function [J,face] = cropface(img)
FaceDetect = vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[150,150]);
bbox=step(FaceDetect,img);
if ~isempty(bbox)
    for i=1:size(bbox,1)
    J=imcrop(img,bbox(i,:));
    end
    face = 1;
else
    J = img;
    face = 0;
end
end