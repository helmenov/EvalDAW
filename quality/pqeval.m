function ODG = pqeval(ref,tes,fs)
%
% ODG = pqeval(ref,tes,fs)
%
%  ODG : Objective Difference Grade
%  ref : reference signal
%  tes : test signal
%  fs  : sampling frequency

rfile = [tmpnam,'rr.wav'];
rfile48 = [tmpnam,'rw.wav'];
tfile = [tmpnam,'tr.wav'];
tfile48 = [tmpnam,'tw.wav'];

[rh,~] = size(ref);
[h,ch] = size(tes);

hmin = min(rh,h);
ref = ref(1:hmin,:);
tes = tes(1:hmin,:);
ODG = zeros(1,ch);
for k = 1:ch
	wavwrite(ref(:,k),fs,rfile);
	Resamp_code = sprintf('ResampAudio -s 48000 %s %s >& /dev/null',...
		 rfile, rfile48);
	system(Resamp_code);
	
	wavwrite(tes(:,k),fs,tfile);
	Resamp_code = sprintf('ResampAudio -s 48000 %s %s >& /dev/null ;',...
		 tfile, tfile48);
	system(Resamp_code);
	PQeval_code = sprintf('PQevalAudio %s %s | grep Grade | cut -c 29- ;',...
		 rfile48,tfile48);
	[~,res] = system(PQeval_code)
	ODG(:,k) = sscanf(res,'%f');
end
system(['rm ',rfile,' ',tfile,' ',rfile48,' ',tfile48]);
ODG = min(ODG);
