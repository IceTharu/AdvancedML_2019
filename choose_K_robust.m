function opt_K = choose_K_robust(feature_vec,search_space)

aic = cell(search_space(2) - search_space(1),1);
bic = cell(search_space(2) - search_space(1),1);
aic_arr = zeros(search_space(2) - search_space(1),1);
bic_arr = zeros(search_space(2) - search_space(1),1);
counter = 0;
for K = search_space(1):search_space(2)
    counter = counter + 1;
    fprintf('Processing %d clusters\n',K);
    bic_best = inf;
    aic_best = inf;
    for rerun = 1:30
        GM = fitgmdist(feature_vec,K,'RegularizationValue',0.001,'Options',statset('MaxIter',2000));
        if GM.BIC < bic_best
            bic{counter} = GM;
            bic_best = GM.BIC;
        end
        if GM.AIC < aic_best
            aic{counter} = GM;
            aic_best = GM.AIC;
        end
    end
    GM_aic = aic{counter};
    GM_bic = bic{counter};
    aic_arr(counter) = GM_aic.AIC;
    bic_arr(counter) = GM_bic.BIC;
end
K_array = [search_space(1):search_space(2)];
opt_K = cell(2,1);
opt_K{1} = aic{find(aic_arr == min(aic_arr))};
opt_K{2} = bic{find(bic_arr == min(bic_arr))};
end