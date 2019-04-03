%% main function 


%% fine-tune cnn

[net, info, expdir] = finetune_cnn();

%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
expdir = 'data/cnn_assignment-lenet';
nets.fine_tuned = load(fullfile(expdir, 'net-epoch-120.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-stl.mat'));

nets.fine_tuned.layers{end}.type = 'softmax';
nets.pre_trained.layers{end}.type = 'softmax';

trained_fine_tuned = vl_simplenn(nets.fine_tuned,data.images.data);
trained_pre_trained = vl_simplenn(nets.pre_trained,data.images.data);

results_fined_tuned = squeeze(trained_fine_tuned(end-3).x);
results_pre_trained = squeeze(trained_pre_trained(end-3).x);

tsne_ft = tsne(results_fined_tuned');
tsne_pt = tsne(results_pre_trained');

subplot(1,2,1);
gscatter(tsne_pt(:,1), tsne_pt(:,2), data.images.labels);
legend(data.meta.classes);
title('pre\_trained')
subplot(1,2,2);
gscatter(tsne_ft(:, 1), tsne_ft(:, 2), data.images.labels);
legend(data.meta.classes);
title('fine\_tuned')
%%
addpath liblinear-2.1
train_svm(nets, data);
