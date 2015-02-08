function y = daad(x,fs,noisepow,complv,ratio)

fprintf('====DA/AD (noise %ddB -> compress %ddB -> speed %d%% start===\n',noisepow,complv,ratio);

% noise add
pow_x = length(x);
n = rand(size(x));
pre_pow_n = sum(n.*n,1);
post_pow_n = pow_x / power(10,-noisepow/10);
n = (ones(size(n,1),1)*sqrt(post_pow_n./pre_pow_n)) .* n; 
y = x + n;	

% compress amplitudes
y_newlv = power(10,complv/20);
y = y_newlv * y;

% speed change
change_speed(y,fs,ratio);

fprintf('====DA/AD (noise %ddB -> compress %ddB -> speed %d%% end===\n',noisepow,complv,ratio);


