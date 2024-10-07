function [new_S_map,new_Dmap,img_out] = delete_seam(img, seam,S_map,D_map)
[r,c,d]=size(img);
[a,b,f]=size(S_map);
[t,s,k]=size(D_map);

img_out = uint8(zeros(r, c - 1, d));
new_S_map = uint8(zeros(a, b - 1, f));
new_Dmap = uint8(zeros(t, s - 1, k));

for i = 1:r
    current_line = img(i,:,:);
    current_line(:, seam(i), :) = [];
    img_out(i,:,:) = current_line;
    current_line_S = S_map(i,:,:);
    current_line_S(:, seam(i), :) = [];
    new_S_map(i,:,:) = current_line_S;
    current_line_D = D_map(i,:,:);
    current_line_D(:, seam(i), :) = [];
    new_Dmap(i,:,:) = current_line_D;
end

end