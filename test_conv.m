pkg load signal

clear all
close all
clc

fs = 500;
N = 500;
ts = 1/fs;

t=0:ts:ts*(N-1);
f=0:fs/N:fs*(N-1)/N;

fm = 30;

mt=cos(2*pi*fm*t);
mf=fft(mt);

fc=100;

ct=cos(2*pi*fc*t);
cf=fft(ct);

zt=mt.*ct;
zf=fft(zt);

figure(1,"position",[0,0,750,750]);
subplot(6,1,1); plot(t,mt); title('m(t)');
subplot(6,1,2); plot(f,abs(mf)); title('M(f)');
subplot(6,1,3); plot(t,ct); title('c(t)');
subplot(6,1,4); plot(f,abs(cf)); title('C(f)');
subplot(6,1,5); plot(t,zt); title('z(t)');
subplot(6,1,6); plot(f,abs(zf)); title('Z(f)');

mzt=zt.*ct;
mzf=fft(mzt);

BW = N/2;
[b a]=butter(1,BW/(2*N)); fmzt=filter(b,a,mzt);
fmzf=fft(fmzt);

sfmzt=fmzt.*2;
sfmzf=fft(sfmzt);

figure(2,"position",[0,750,750,750]);
subplot(6,1,1); plot(t,mzt); title('mz(t)');
subplot(6,1,2); plot(f,abs(mzf)); title('Mz(f)');
subplot(6,1,3); plot(t,fmzt); title('filtered mz(t)');
subplot(6,1,4); plot(f,abs(fmzf)); title('filtered Mz(f)');
subplot(6,1,5); plot(t,sfmzt); title('scaled filtered mz(t)');
subplot(6,1,6); plot(f,abs(sfmzf)); title('scaled filtered Mz(f)');

difference_n = sum(abs(mt.-sfmzt));
difference_n

pause();

% 2. with 2-step interpolation
clear all

fs = 500;
N = 500;
ts = 1/fs;

t=0:ts/2:ts/2*(2*N-1);
f=0:2*fs/(2*N):(2*fs)*(2*N-1)/(2*N);
N=2*N;

fm = 30;

mt=cos(2*pi*fm*t);
mf=fft(mt);

fc=100;

ct=cos(2*pi*fc*t);
cf=fft(ct);

zt=mt.*ct;
zf=fft(zt);

figure(3,"position",[0,0,750,750]);
subplot(6,1,1); plot(t,mt); title('m(t)');
subplot(6,1,2); plot(f,abs(mf)); title('M(f)');
subplot(6,1,3); plot(t,ct); title('c(t)');
subplot(6,1,4); plot(f,abs(cf)); title('C(f)');
subplot(6,1,5); plot(t,zt); title('z(t)');
subplot(6,1,6); plot(f,abs(zf)); title('Z(f)');

mzt=zt.*ct;
mzf=fft(mzt);

BW = N/2;
[b a]=butter(1,BW/(2*N)); fmzt=filter(b,a,mzt);
fmzf=fft(fmzt);

sfmzt=fmzt.*2;
sfmzf=fft(sfmzt);

figure(4,"position",[0,750,750,750]);
subplot(6,1,1); plot(t,mzt); title('mz(t)');
subplot(6,1,2); plot(f,abs(mzf)); title('Mz(f)');
subplot(6,1,3); plot(t,fmzt); title('filtered mz(t)');
subplot(6,1,4); plot(f,abs(fmzf)); title('filtered Mz(f)');
subplot(6,1,5); plot(t,sfmzt); title('scaled filtered mz(t)');
subplot(6,1,6); plot(f,abs(sfmzf)); title('scaled filtered Mz(f)');

difference_m_tot = sum(abs(mt.-sfmzt));
difference_m_tot
mt = resample(mt,1,2);
sfmzt = resample(sfmzt,1,2);
difference_m_rcv = sum(abs(mt.-sfmzt));
difference_m_rcv

pause();


