function [er,ODG] = AllDoDetection(wavname,dat,Nite,varargin);
owave = sprintf('/opt/ihc/audio/sample/%d.wav',wavname);
rwave = sprintf('%d',wavname);
for i=1:length(varargin)
	tmp = sprintf('_%d',varargin{i});
	rwave = strcat(rwave,tmp)
end
rwave = strcat(rwave,'_stego.wav');

[o,fs] = wavread(owave);
[x,fs] = wavread(rwave);

addpath('quality');
ODG = pqeval(o,x,fs);

addpath('robustness');
y = ihc2013attack(x,fs);
er.orig = DoDetection(y.orig,fs,dat,Nite,varargin);
er.mp3o = DoDetection(y.mp3o,fs,dat,Nite,varargin);
er.wgn0 = DoDetection(y.wgn0,fs,dat,Nite,varargin);
er.bapf = DoDetection(y.bapf,fs,dat,Nite,varargin);
er.tsmp = DoDetection(y.tsmp,fs,dat,Nite,varargin);
er.tsmm = DoDetection(y.tsmm,fs,dat,Nite,varargin);
er.spep = DoDetection(y.spep,fs,dat,Nite,varargin);
er.spem = DoDetection(y.spem,fs,dat,Nite,varargin);
er.echo = DoDetection(y.echo,fs,dat,Nite,varargin);
er.mp3t = DoDetection(y.mp3t,fs,dat,Nite,varargin);
er.mp4a = DoDetection(y.mp4a,fs,dat,Nite,varargin);
er.daad = DoDetection(y.daad,fs,dat,Nite,varargin);
