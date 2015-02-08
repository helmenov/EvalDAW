function y = mp3encdec(x,fs,kbps)
fprintf('====mp3encdec start===\n');
% lame --cbr -q 0 -m j -b 128kbps
% lame xmp3.mp3 --decode x_mp3 

[c, ch] = size(x);
wfile = [tmpnam, 'w.wav'];
rfile = [tmpnam, 'r.mp3'];

wavwrite(x, fs, wfile);
enc_code = sprintf('lame --cbr -q 0 -m j -b %g %s %s',kbps,wfile,rfile);
system(enc_code);
dec_code = sprintf('lame --decode %s %s',rfile,wfile);
system(dec_code);
y = wavread(wfile);
system(['rm ', wfile, ' ', rfile]);
fprintf('====mp3encdec end===\n\n');