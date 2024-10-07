function seam = find_seam(energy_map)
[r,c,~]=size(energy_map);
M=repmat(energy_map(1, :), r, 1);
edges_from = zeros(r, c);
for i = 2:r
    for j = 1:c
        t=0;
        if (j == 1)
            origin_nodes = M(i-1, 1:2);
            t=1;
        elseif (j == c)
            origin_nodes = M(i-1, end-1:end);
        else
            origin_nodes = M(i-1, j-1:j+1);
        end
        
        [M(i,j), index] = min(energy_map(i,j) + origin_nodes);
        
        edges_from(i,j) = j + index - 2 + t;
    end
end
[~, index] = min(M(end, :)); 
seam = index .* ones(r, 1);
for i = r:-1:2
    seam(i - 1) = edges_from(i, seam(i));
end
end