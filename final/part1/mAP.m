function [ indexes, map] = mAP(labels, decision_values)
    nc = size(labels, 2);
    ni = size(labels[0], 2);
    assert(nc==size(decision_values, 2));
    APs = zeros(nc, 1);
    indexes = cell(nc, 1)
    for i = 1:nc
        dv = decision_values(i);
        label = labels(i);
        [~, I] = sort(dv, 'decend');
        indexes(i) = I
        ap = 0;
        for j = 1:ni
            ap = ap + sum(labels(1:j))/j;
        end
        ap = ap/ni;
        APs(i) = ap;
    end
    map = mean(APs)
end