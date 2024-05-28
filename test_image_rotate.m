clear;close all;

imageFileName = ('./test1_0.jpg');
image = imread(imageFileName);
figure, imshow(image);title('Изначально');


dublicateImage = imrotate(image, 90, 'bicubic', 'crop');
figure, imshow(dublicateImage);title('Повернутое 2');

cropImage = imcrop(image, [70 40 100 60]);
figure, imshow(cropImage); title('Обрезанное изначально');


cropImage2 = imcrop(dublicateImage, [70 40 100 60]);
figure, imshow(cropImage2); title('Обрезанное повернутое');

imwrite(cropImage2, 'test1_4.jpg');
