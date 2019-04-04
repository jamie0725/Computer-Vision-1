function [ classifiers ] = train_classifiers(trainSet)
% trainSet:[num_class, num_imgs, num_features]

    [nc, ni, nf] = size(trainSet);
    classifiers = {};
    index = 1:nc*ni;    
    dataInstances = permute(trainSet, [2 1 3]);    
    dataInstances = reshape(dataInstances, nc*ni, nf);
    % size(dataInstances)
    for i = 1:nc
        % labels = zeros(nc*ni, 1);
        % pos_index = index>(i-1)*ni & index <i*ni;
        % labels(pos_index) = 1;
        labels = generate_labels(nc, ni, i);
        % dataInstances = trainSet(pos_index)
        labels = (labels);
        % model = train(labels, dataInstances, '-s 0 -t %d -q');
        rand_indices = randperm(size(nc*ni, 1));
        X = dataInstances(rand_indices, :); 
        Y = labels(rand_indices, :);
        c = [0, 1; 4, 0];
        SVMModel = fitcsvm(dataInstances, labels, 'KernelFunction','rbf', 'cost', c);
        % SVMModel = fitcsvm(dataInstances, labels, 'KernelFunction','rbf',...
        % 'Standardize',true, 'cost', c);
        classifiers{i}=SVMModel;
    end
end