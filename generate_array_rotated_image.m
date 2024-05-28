clear;close all;

imageFileName = ('./test1_0.jpg');
image = imread(imageFileName);
figure, imshow(image);title('Изначально');

stepAngleRotate = 10;

curAngle = stepAngleRotate;

rotatedImages = cell(1, 360 / stepAngleRotate);

while curAngle <= 100
    curRotatedImage = imrotate(image, curAngle, 'bicubic', 'crop');
    figure, imshow(curRotatedImage);title('угол = ' + string(curAngle));
    
    curCropImage = imcrop(curRotatedImage, [70 40 100 60]);
    figure, imshow(curCropImage); title('Обрезанное, угол = ' + ... 
        string(curAngle));

    rotatedImages{curAngle / stepAngleRotate} = curCropImage;
    
    curAngle = curAngle + stepAngleRotate;
end

for idxCurImage = 1:length(rotatedImages)
    imwrite(rotatedImages{idxCurImage}, 'test1_rotated_' + ... 
        string(idxCurImage) + '.jpg')
end