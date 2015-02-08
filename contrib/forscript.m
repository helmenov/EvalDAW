function forscript(varargin)

li = [27    32    35    40    65    66    69    70 101];
dat = load('/opt/ihc/audio/payload/payload.txt');

for i=1:length(li)
	DoEmbedding(li(i),dat,varargin);
	[er(i),er_std(i),ODG(i)]=AllDoDetection(li(i),dat,varargin);
end

plot_er(li,varargin);
epsname = sprintf('result');
for i=1:nargin
	tmp = sprintf('_%d',varargin{i});
	epsname = strcat(epsname,tmp);
end
print('-deps',epsname);
