function visualize_erp(sorted_clusters,sorted_features,sorted_d2,data,c_range,labels,do_save)
K = size(sorted_clusters,1);
f3 = figure(3);
for i = 1:14
    subplot(5,3,i)
    plot(data(i,:))
    ylim([-5000 5000])
end
for i = 1:K
    c = 10*log10(sorted_features{i});
    fprintf('Standard deviation of distances is %d\n',std(sorted_d2{i}))
    data = cell2mat(sorted_clusters{i});
    f1 = figureFullScreen(1);
%     f1 = figure(1);
    colormap('gray')
    imagesc(c)
    colorbar
    caxis(c_range)
    f2 = figureFullScreen(2);
    for j = 1:14
        subplot(5,3,j)
        plot(data(j,:))
        xlabel('Data points')
        ylabel(labels{j})
        ylim([-5000 5000])
        set(gca,'FontSize',15)
    end
    f4 = figureFullScreen(4);
    bins = [0:160];
    histogram(sorted_d2{i},bins)
    
    figure(1)
    title(strcat('Sorted feature vector of cluster',{' '},mat2str(i)))
    set(gca,'FontSize',20)
    figure(2)
    sgtitle(strcat('Sorted data in cluster',{' '},mat2str(i)),'FontSize',20)
    figure(4)
    title(strcat('Histogram of squared Mahalanobis distances in cluster',{' '},mat2str(i)))
    xlabel('Distance')
    ylabel('Count')
    set(gca,'FontSize',20)
    if do_save
        figure(1)
        saveas(gcf,['fig\feat_c' mat2str(i) '_pca.png'])
        figure(2)
        saveas(gcf,['fig\data_c' mat2str(i) '_pca.png'])
        figure(4)
        saveas(gcf,['fig\mahal_c' mat2str(i) '_pca.png'])
        s = cellfun(@std,sorted_d2);
        m = cellfun(@mean,sorted_d2);
        s_dest = ['fig\std_pca.txt'];
        m_dest = ['fig\mean_pca.txt'];
        dlmwrite(s_dest,s','\t')
        dlmwrite(m_dest,m','\t')
        close all
    else
        pause()
    end
    
end
end
    