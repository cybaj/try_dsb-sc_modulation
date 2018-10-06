pkg load signal

clear all
close all
clc

[x,fs] = audioread('Alarm01.wav');
x = x(:, 1);
Ts= 1/fs;
N=length(x);
t=0:Ts:Ts*(N-1);
f=0:fs:fs*(N-1);

% 2-times interpolation
x1 = resample(x,2,1);

t1 = 0:(1/(2*fs)):(1/(2*fs))*((2*N)-1);
f1 = 0:(2*fs)/(2*N):(2*fs)*(2*N-1)/(2*N);
N1 = 2*N;

% bandpass filter
BW=(1/4)*N1;
[b a]=butter(1,[(1/2-(BW/2)) (1/2+(BW/2))]); m_t=filter(b,a,x1);
m_f=fft(m_t);

% DSB-SC modulation
fc=100000;
c_t=2*cos(2*pi*fc*t1);
c_t=c_t';
s_t=c_t.*m_t;
s_f=fft(s_t);

figure(1);
subplot(4,1,1),plot(t1,m_t); title('m(t)'); axis([0 5 -1 1]);
subplot(4,1,2);stem(f1,abs(m_f)/N1);title('M(f)');
subplot(4,1,3),plot(t1,s_t); title('s_d_s_b(t)'); axis([0 5 -1 1]);
subplot(4,1,4);stem(f1,abs(s_f)/N1);title('S_d_s_b(f)');

% DSB-SC demodulation
m_r=s_t.*c_t; 
m_r_t=filter(b,a,m_r);
m_r_f=fft(m_r_t);
figure(2)
subplot(2,1,1); plot(t1,m_r_t); axis([0 5 -1 1]); title('m_r(t)');
subplot(2,1,2); stem(f1,abs(m_r_f)/N1); title('M_r(f)');

% 원래신호와 복원신호 비교
figure(3)
subplot(2,1,1),plot(t1,x1); title('m(t)'); axis([0 5 -1 1]);
subplot(2,1,2),plot(t1,m_r_t); title('m_r(t)'); axis([0 5 -1 1]);

% .wav파일 만들기
audiowrite('Newalarm01.wav',m_r_t,2*fs);
