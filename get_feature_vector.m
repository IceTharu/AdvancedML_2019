function feature_vec = get_feature_vector(chunks,descriptor)
n = size(chunks,2);
feature_vec = [];
for i = 1:n
    feature = descriptor(chunks{i});
    feature_vec = [feature_vec;feature];
end
end
    