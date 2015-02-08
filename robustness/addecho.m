function y = addecho(x,fs,msdelay,dbgain)

fprintf('====addecho %fmsdelay %fdBgain start===\n',msdelay,dbgain);
gain = power(10,dbgain/20);

zero_pad = zeros(msdelay/1000*fs-1,size(x,2));

size(zero_pad);
size(x);

E = [zero_pad;gain*x];
D =  [x;zero_pad];

%subplot(2,1,1),plot(E);
%subplot(2,1,2),plot(D);
y = E + D;

fprintf('====addecho %fmsdelay %fdBgain end===\n\n',msdelay,dbgain);
