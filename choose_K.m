function opt_K = choose_K(feature_vec,search_space)

aic = zeros(1,search_space(2) - search_space(1)); 
bic = zeros(1,search_space(2) - search_space(2));
counter = 0;
for K = search_space(1):search_space(2)
    counter = counter + 1;
    fprintf('Processing %d clusters\n',K);
    GM = fitgmdist(feature_vec,K,'RegularizationValue',0.001,'Options',statset('MaxIter',2000));
    aic(counter) = GM.AIC;
    bic(counter) = GM.BIC;
end
K_array = [search_space(1):search_space(2)];
avg = (aic + bic)/2;
opt_K = zeros(2,1);
opt_K(1) = K_array(find(bic == min(bic)));
opt_K(2) = K_array(find(avg == min(avg)));
end