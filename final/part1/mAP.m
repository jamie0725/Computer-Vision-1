function [ indexes, map, APs] = mAP(labels, score_li)
    nc = size(labels, 1);
    ni = size(labels{1}, 1)/nc;
    assert(nc==size(score_li, 1));
    APs = zeros(nc, 1);
    indexes = cell(nc, 1);
    for i = 1:nc
        dv = score_li{i};
        label = labels{i};
        [~, I] = sort(dv, 'descend');
        indexes{i} = I;
        ap = 0;
        ranked_label = label(I);
        for j = 1:ni*nc
            ap = ap + ranked_label(j) * double(sum(ranked_label(1:j)))/j;
        end
        ap = ap/ni
        APs(i) = ap;
    end
    map = mean(APs)
end