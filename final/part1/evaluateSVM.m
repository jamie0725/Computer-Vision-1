function [ indexes, map, APs] = evaluateSVM(testSet, classifiers)

    [nc, ni, nf] = size(testSet);    
    testSet = permute(testSet, [2 1 3]);    
    testSet = reshape(testSet, nc*ni, nf, []); 
    predicted_label_li = cell(nc, 1);
    accuracy_li = cell(nc, 1);
    score_li = cell(nc, 1);
    labels_li = cell(nc, 1);
    for i = 1:nc
        classifier = classifiers{i};
        labels = generate_labels(nc, ni, i);
        labels_li{i} = labels;
        % [predicted_label, accuracy, decision_value] = predict(labels, testSet, classifier);
        [predicted_label, score] = predict(classifier, testSet);
        [~,I] = sort(score, 'descend');
        predicted_label_li{i} = predicted_label;
        sum(predicted_label)
        % score(1:500,:)
        cp = classperf(labels, predicted_label);
        accuracy_li{i} = cp.ErrorRate
        score_li{i} = score(:, 2);
    end
    [indexes, map, APs] = mAP(labels_li, score_li);
    % accuracy = mean(accuracy_li)
end