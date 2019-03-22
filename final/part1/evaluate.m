function [ indexes, map, accuracy ] = evalSVM(testSet, classifiers)

    nc, ni, nf = size(testSet)
    testSet = reshape(testSet, nc*ni, nf, [])
    predicted_label_li = {}
    accuracy_li = {}
    decision_value_li = {}
    labels_li = {}
    for i = 1:nc
        classifier = classifiers(i)
        labels = generate_labels(nc, ni, i)
        labels_li(i) = labels
        [predicted_label, accuracy, decision_value] = predict(labels, testSet, classifier)
        [~,I] = sort(decision_value, 'descend');
        predicted_label_li(i) = predicted_label
        accuracy_li(i) = accuracy
        decision_value_li(i) = decision_value
    end
    indexes, map = mAP(labels, decision_value_li)
    accuracy = mean(accuracy_li)
end