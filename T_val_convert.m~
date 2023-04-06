


s = 30000;             % amount of samples
p = [0.05;0.01;0.001];      % p-values to test
nvox = 8900;               % amount of comparisons
alpha = p./nvox;            % Bonferroni pvalue

for i =1:length(p)
    for j = 1:length(s)
            t_crit(i,j)= tinv(1-alpha(i)/2,s(j)-2);
    end
end



Pval=2*(1-tcdf(abs(9),nvox-2))



