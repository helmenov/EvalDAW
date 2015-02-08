function out = pitch_change(sig, sf, ratio);

% pitch change using picola

fprintf('====pitch_change %fratio start===\n',ratio);
[c, ch] = size(sig);
wfile = [tmpnam, 'w.wav'];
rfile = [tmpnam, 'r.wav'];

for k=1:ch
  wavwrite(sig(:,k), sf, wfile);
  system(sprintf('picola %s %s %g', wfile, rfile, ratio));
  system(sprintf('ResampAudio -s %d %s %s >& /dev/null', round(sf/ratio), rfile, wfile));
  tmp = wavread(wfile);
  out(1:length(tmp),k) = tmp;
end
system(['rm ', wfile, ' ', rfile]);
fprintf('====pitch_change %fratio end===\n\n',ratio);
  
