function [ classifiers ] = trainClassifiers(trainSet)
% trainSet:[num_class, num_imgs, num_features]

    nc, ni, nf = size(trainSet)
    classifiers = {}
    index = 1:nc*ni
    for i = 1:nc
        labels = zeros(nc*ni)
        pos_index = index>(i-1)*ni & index <i*ni
        labels(pos_index) = 1
        % dataInstances = trainSet(pos_index)
        dataInstances = reshape(trainSet, nc*ni, nf)
        labels = double(labels)
        model = train(labels, dataInstances, '-s 0 -t %d -q')
        classifiers(i)=model
    end
end