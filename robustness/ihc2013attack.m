function y = ihc2013attack(x,fs)
%
% y = ihc2013attack(x,fs)
% 
% ref. http://www.ieice.org/iss/emm/ihc/audio/audio2012_v1.1.pdf
%
% following is required:
% bpf.mat: http://www.ieice.org/iss/emm/ihc/audio/bpf.mat
% picola: http://keizai.yokkaichi-u.ac.jp/~ikeda/research/picola-jp.html
% lame-3.99.3: http://sourceforge.net/projects/lame/files/lame/3.99/
% AFsp-v8r2: http://www-mmsp.ece.mcgill.ca/documents/Downloads/AFsp/
% neroAAC: http://www.nero.com/jpn/technologies-aac-codec.html
%
% mp3encdec.m
% addnoise.m
% pitch_change.m : http://www.ieice.org/iss/emm/ihc/audio/pitch_change.m
% change_speed.m
% addecho.m
% mp4encdec.m
%
% $Id: ihc2013attack.m,v 1.2 2013/03/05 15:22:56 kotaro Exp $
%

BPFMATFILE = ['bpf.mat'];
xxx = x;
while size(xxx,1)<60*fs
	xxx = [xxx;x];
end
% save original
y.orig = xxx(1:60*fs,:);

% mp3 128 kbps jointstereo
y.mp3o = mp3encdec(y.orig,fs,128);

% gaussian noise 36dBSNR
y.wgn0 = addnoise(y.orig,fs,36);
y.wgn1 = addnoise(y.orig,fs,36);
y.wgn2 = addnoise(y.orig,fs,36);
y.wgn3 = addnoise(y.orig,fs,36);
y.wgn4 = addnoise(y.orig,fs,36);
y.wgn5 = addnoise(y.orig,fs,36);
y.wgn6 = addnoise(y.orig,fs,36);
y.wgn7 = addnoise(y.orig,fs,36);
y.wgn8 = addnoise(y.orig,fs,36);
y.wgn9 = addnoise(y.orig,fs,36);

% Bandpass filter
BPFCOEF=load(BPFMATFILE);
y.bapf = filter(BPFCOEF.bz,BPFCOEF.ap,y.orig);

% TSM -4% , +4%
y.tsmp = pitch_change(y.orig,fs,1.04);
y.tsmm = pitch_change(y.orig,fs,0.96);

% Speed -10%, +10%
y.spep = change_speed(y.orig,fs,1.10);
y.spem = change_speed(y.orig,fs,0.90);

% echo 100ms delay, 6dB gain
y.echo = addecho(y.orig,fs,100,6);

% mp3 twice
y.mp3t = mp3encdec(y.mp3o,fs,128);

% mp4aac
y.mp4a = mp4encdec(y.orig,fs,96);

% DA/AD 
y.daad = daad(y.orig,fs,-80,-2,0.999);
