function er = DoDetection(astego,fs,m,Nite,varargin)
%
% er = DoDetection(astego,fs,m,Nite)
%
% astego : attacked stego signal (example y.mp3 )
% fs: sampling rate
% m: original message


[h,ch] = size(astego);
for ite = 1:Nite
	ich = randperm(ch,1);
	if 0
		seg_1 = randperm(fs*15,1);
	else
		seg_1 = 1;
	end
	seg_end = seg_1+fs*30-1;
	%%	seg_end = seg_1+fs*45-1;
	y = astego(seg_1:seg_end,ich);

	% Detection Code here
	% [m_stego(:,ite)] = detection_code(y,....);
	% m_stego = decode(y,fs,m,varargin);
	
	% BEGIN == fix for tsedec == 
	wavwrite(y,fs,'tseenc.wav');	
	[m_stego, idx, cn, flag] = tse_dec;
	% END == fix for tsedec ==
	
	lengthm = min(length(m),length(m_stego));

	er(ite) = 100 * length(find(m(1:lengthm)-m_stego(1:lengthm))) / lengthm; 
end
er = mean(er);
er
input('');
