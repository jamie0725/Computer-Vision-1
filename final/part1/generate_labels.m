function [ labels ] = genLabels(nc, ni, i)
    index = 1:nc*ni;
    labels = zeros(nc*ni, 1);
    pos_index = index>(i-1)*ni & index <i*ni;
    labels(pos_index) = 1;
end