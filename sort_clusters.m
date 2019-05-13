function [sorted_clusters, sorted_features, sorted_d2] = sort_clusters(idx,d2,chunks,feature_vec)
K = size(d2,2);
sorted_clusters = cell(K,1);
sorted_features = cell(K,1);
sorted_d2 = cell(K,1);
for i = 1:K
    idx_ = idx == i;
    data = chunks(idx_);
    feat = feature_vec(idx_,:);
    dist = d2(idx_,i);
    [dist_sorted,s] = sort(dist);
    sorted_clusters{i} = data(1,s);
    sorted_features{i} = feat(s,:);
    sorted_d2{i} = dist_sorted;
end
end
    
    