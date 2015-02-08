function y = mp4encdec(x,fs,kbps)
fprintf('====mp4encdec start===\n');
% neroAacEnc -he -br 96000 -if %stegowav -of %encodedmp4
% neroAacDec -if %encodedmp4 -of %decodedwav

% lame --cbr -q 0 -m j -b 128kbps
% lame xmp3.mp3 --decode x_mp3 

[c, ch] = size(x);
wfile = [tmpnam, 'w.wav'];
rfile = [tmpnam, 'r.mp3'];

wavwrite(x, fs, wfile);
enc_code = sprintf('neroAacEnc -he -br %g -if %s -of %s',kbps,wfile,rfile);
system(enc_code);
dec_code = sprintf('neroAacDec -if %s -of %s',rfile,wfile);
system(dec_code);
y = wavread(wfile);
system(['rm ', wfile, ' ', rfile]);
fprintf('====mp4encdec end===\n\n');