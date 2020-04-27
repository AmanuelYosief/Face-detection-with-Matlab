function  cropandsave(var)
disp([ "ZUCKKKKKKKKKKKKKKK", var ]);
  IM = imread(var);
  %figure
  %imshow(IM);
  info = imfinfo(var)
if isfield(info,'Orientation')
    orient = info(1).Orientation;
    switch orient
        case 1
            %normal, leave the data alone
        case 2
            IM = IM(:,end:-1:1,:);         %right to left
            disp('Image roated right to left');
        case 3
            IM = IM(end:-1:1,end:-1:1,:);  %180 degree rotation
            disp('Image roated 1    80 degree rotation');
        case 4
            IM = IM(end:-1:1,:,:);         %bottom to top
            disp('Image roated bottom to top');
        case 5
            IM = permute(IM, [2 1 3]);     %counterclockwise and upside down
            disp('Image roated counterclockwise and upside down');
        case 6
            IM = rot90(IM,3);              %undo 90 degree by rotating 270
            disp('Image roated by 270');
            imwrite(IM,var);
            %%figure
            %figure
            %imshow(IM);
        case 7
            IM = rot90(IM(end:-1:1,:,:));  %undo counterclockwise and left/right
            disp('Image roated undo counterclockwise and left/right');
        case 8
            IM = rot90(IM);                %undo 270 rotation by rotating 90
            disp('Image roatedundo 270 rotation by rotating 90');
        otherwise
        disp('unknown orientation %g ignored\n', orient);
    end
end












