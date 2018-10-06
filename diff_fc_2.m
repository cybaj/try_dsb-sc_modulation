pkg load signal

clear all
close all
clc

fs = 1000;
N = 1000;
ts = 1/fs;

t=0:ts:ts*(N-1);
f=0:fs/N:fs*(N-1)/N;

fm = 30;

mt=cos(2*pi*fm*t).*cos(2*pi*fm*2*t);
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

% 2. double carrier frequency 
clear all

fs = 1000;
N = 1000;
ts = 1/fs;

t=0:ts:ts*(N-1);
f=0:fs/N:fs*(N-1)/N;

fm = 30;

mt=cos(2*pi*fm*t).*cos(2*pi*fm*2*t);
mf=fft(mt);

fc=200;

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

pause();
