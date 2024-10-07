clc;
clear;
close all; 

im =  imread('Samples/Baby.png');
Depth_map = imread('Samples/Baby_DMap.png');
Saliency_map =imread('Samples/Baby_SMap.png'); 

[Ix, Iy] = gradient(double(rgb2gray(im)));
gradient_map=abs(Ix)+abs(Iy);
energy_map = 0.01* double(gradient_map)+0.2*double(Saliency_map)+ 0.95*double(Depth_map);
% imagesc(energy_map);

[r, c, d] = size(im);
seam = find_seam(energy_map);

[new_S_map,new_Dmap,img_out] = delete_seam(im, seam,Saliency_map,Depth_map);
x =  size(img_out,2);
y = size(im,2);
resizing_factor=0.5;

while(x>resizing_factor*y)
    
    [Ix, Iy] = gradient(double(rgb2gray(img_out)));
    gradient_map=abs(Ix)+abs(Iy);
    energy_map = 0.01* double(gradient_map)+0.2*double(new_S_map)+ 0.95*double(new_Dmap);
    seam = find_seam(energy_map);
    [new_S_map,new_Dmap,img_out] = delete_seam(img_out, seam,new_S_map,new_Dmap);
    x=x-1;

end
       
% imshow(im); title('Original image', 'FontSize' , 15,'Color','blue'); 
% figure;
% imshow(img_out); title('Resized image', 'FontSize' , 15,'Color','blue'); 
 imwrite(img_out,'Results/Baby_0.5_res.png');
