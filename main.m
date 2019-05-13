clear all;close all;clc
path_to_data = 'C:\Users\vijay\Documents\AvanceretMaskineLæring\real_EEG_data\1.edf'
[hdr,record] = edfread(path_to_data);
data = record(1:14,:);
chunks = get_chunks(data,256);
feature_vec = get_feature_vector(chunks,@descriptor);
% K = choose_K(feature_vec,[1 10]);
% chosen_K = K(1);
chosen_K = 5;
[idx, d2] = fit_gmm(feature_vec,chosen_K);
[sorted_clusters,sorted_features, sorted_d2] = sort_clusters(idx,d2,chunks,feature_vec);
visualize_erp(sorted_clusters,sorted_features,sorted_d2,data,[-35 0],hdr.label,false);



function desc = descriptor(X)
%Next 2 lines are for PCA
[coeff,score,latent,tsquared,explained,mu] = pca(X');
desc = abs(coeff(:,1))';
% Next 3 lines are for histogram analysis
% X = X(:);
% bins = [-3000:100:3000];
% desc = hist(X,bins);

end