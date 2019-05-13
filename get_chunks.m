function chunks = get_chunks(data,win)
n = floor(size(data,2)/win);
rest = size(data,2) - win*n;
chunks = mat2cell(data(:,1:win*n),14,win*ones(1,n));
end