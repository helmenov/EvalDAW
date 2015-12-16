#透かし埋め込みプログラムと検出プログラムは以下の形にあわせなければならない

埋め込みプログラム（仮にembed.m）
- [y,err] = embed(x,fs,m,varargin);

検出プログラム（仮にdecode.m)
- m_stego = decode(y,fs,m,varargin);

#DoEmbedding.m

埋め込みを行う．

ホストデータは指定された信号

[err] = DoEmbedding(wavname,m,varargin)
- wavnameはSQAMの番号
- mはペイロードビット列
- その他はembed，decodeに渡すパラメータ embed(x,fs,m,varargin);

#DoDetection.m

検出を行う．

ステゴデータの「ある始点」から30秒を使う．「ある始点」はプログラム中のseg_1

[er] = DoDetection(astego,fs,m,varargin)
- astegoは ステゴデータ．(wavではない）
- fsはサンプリング周波数
- mは originalのペイロードビット列
- その他はembed, decodeに渡すパラメータ decode(y,fs,m,varargin);

# AllDoDetection.m
客観音質評価（中でpeaqを呼ぶ）

すべての攻撃（中でihc20**attackを呼ぶ）

各攻撃に対する検出を行うラッパ

[er,ODG] = AllDoDetection(wavname,m,varargin);
- wavnameはSQAMの番号
- mは originalペイロードビット列
- その他はembed, decodeに渡すパラメータ
   er.mp3o = DoDetection(y.mp3o,fs,m,varargin);

# ihc20**attack(x,fs)
y = ihc20**attack(x,fs)
yはリスト構造体．

```ihc20**attack.m
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
```

# pqeval.m
ODG = pqeval(ref,tes,fs)

PQevalAudioを呼び出すラッパ

