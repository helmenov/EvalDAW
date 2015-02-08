function y = addnoise(x,fs,dbSNR)
fprintf('====addnoise %ddBSNR start===\n',dbSNR);
pow_x = sum(x.*x,1);
n = rand(size(x));
pre_pow_n = sum(n.*n,1);
post_pow_n = pow_x / power(10,dbSNR/10);
n = (ones(size(n,1),1)*sqrt(post_pow_n./pre_pow_n)) .* n; 
y = x + n;	
fprintf('====addnoise %ddBSNR end===\n\n',dbSNR);