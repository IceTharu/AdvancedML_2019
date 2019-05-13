function [idx, d2] = fit_gmm(feature_vec,K,GM)
if exist('GM')
    fprintf('Model already fitted. Model has %d clusters',GM.NumComponents);
    [idx,~,~,~,d2] = cluster(GM,feature_vec);
else
%     idx_train = zeros(size(feature_vec,1),1);
%     idx = randperm(size(feature_vec,1),floor(size(feature_vec,1)*0.6));
%     idx_train(idx) = 1;
%     train = feature_vec(idx_train == 1,:);
%     val = feature_vec(idx_train == 0,:);
    bic_best = inf;
    fprintf('Fitting GMM with %d clusters\n',K);
    for i = 1:1000
        GM = fitgmdist(feature_vec,K,'RegularizationValue',0.001,'Options',statset('MaxIter',2000));
%         [~,Nlog] = posterior(GM,val);
        if GM.BIC < bic_best
            GM_best = GM;
            bic_best = GM.BIC;
        end
    end
    fprintf('Fitted model validation bic value of %d\n',bic_best);
    [idx,~,~,~,d2] = cluster(GM_best,feature_vec);
end
end