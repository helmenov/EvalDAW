function y = plot_er(li,matname)
load(matname);
N = length(ODG);
atk = ['orig';'mp3o';'wgn0';'bapf';'tsmp';'tsmm';'spep';'spem';'echo';'mp3t';'mp4a';'daad'];

er_orig = [];
er_mp3o = [];
er_wgn0 = [];
er_bapf = [];
er_tsmp = [];
er_tsmm = [];
er_spep = [];
er_spem = [];
er_echo = [];
er_mp3t = [];
er_mp4a = [];
er_daad = [];

for i=1:floor(N/5)+1
	figure(i),title(matname);
end
for i=1:N
	erdata=[er(i).orig, er(i).mp3o, er(i).wgn0, er(i).bapf, er(i).tsmp, ...
			  er(i).tsmm, er(i).spep, er(i).spem, er(i).echo, er(i).mp3t, er(i).mp4a, er(i).daad];
	figure(floor(i/5)+1),subplot(5,1,floor(rem(i,5))+1),bar(1:10,erdata);
	ylim([0 100]);
	set(gca, 'XTickLabel',atk ,'XTick',1:length(atk));
	str = sprintf('%d',li(i));
	ylabel(str);
	
	er_orig = [er_orig; er(i).orig];
	er_mp3o = [er_mp3o; er(i).mp3o];
	er_wgn0 = [er_wgn0; er(i).wgn0];
	er_bapf = [er_bapf; er(i).bapf];
	er_tsmp = [er_tsmp; er(i).tsmp];
	er_tsmm = [er_tsmm; er(i).tsmm];
	er_spep = [er_spep; er(i).spep];
	er_spem = [er_spem; er(i).spem];
	er_echo = [er_echo; er(i).echo];
	er_mp3t = [er_mp3t; er(i).mp3t];
	er_mp4a = [er_mp4a; er(i).mp4a];
	er_daad = [er_daad; er(i).daad];
end
aver = sprintf('%3.1f %3.1f %3.1f %3.1f %3.1f %3.1f %3.1f %3.1f %3.1f %3.1f',...
	mean(er_orig),mean(er_mp3o),mean(er_wgn0),mean(er_bapf),mean(er_tsmp),...
	mean(er_tsmm),
	mean(er_spep),mean(er_spem),mean(er_echo),mean(er_mp3t),mean(er_mp4a),mean(er_daad))
for i=1:floor(N/5)+1
	figure(i),xlabel(aver);
end
	

