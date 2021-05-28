clc; clear;
%% given specification
Wp = 0.3*pi; % passband edge frequency (rad/sec)
Ws = 0.4*pi; % stopband edge frequency (rad/sec)
Rp = 0.2;     % max passband attenuation (dB)
Rs= 20;    % max stopband attenuation (dB)
%% windows
M= 25;  %arbitrary
w_rec = rectwin(M+1);
w_ham = hamming(M+1);

%% FIR LPF by windowing
b_rec = fir1(M, Wp/pi, w_rec);
b_ham = fir1(M, Wp/pi, w_ham);

%impulse response coefficients
[i_rec, t_rec] = impz(b_rec, 1);
[i_ham, t_ham] = impz(b_ham, 1);

% frequency response
[h_rec,w] = freqz(b_rec, 1);
[h_ham,w] = freqz(b_ham, 1);

% group delay
[gd_rec,w1] = grpdelay(b_rec, 1);
[gd_ham,w1] = grpdelay(b_ham, 1);

%% plot
f1 = figure('Name', 'Linear-Phase FIR LPF by Windowing', 'NumberTitle', 'off');

%impulse response coefficients
subplot(2,5,1);
stem(t_rec, i_rec);
title('impulse response of Rectangular');
subplot(2,5,6);
stem(t_ham, i_ham);
title('impulse response of Hamming');

% magnitude in dB = 20*log10(abs(h))
subplot(2,5,2);
plot(w/pi, 20*log(abs(h_rec)));
xlabel('Radian frequency');
ylabel('dB');
title('mag response in dB of Rectangular');
subplot(2,5,7);
plot(w/pi, 20*log(abs(h_ham)));
xlabel('Radian frequency');
ylabel('dB');
title('mag response in dB of Hamming');

% magnitude linear = abs(h)
subplot(2,5,3);
plot(w/pi, abs(h_rec));
xlabel('Radian frequency');
ylabel('Amplitude');
title('lin mag response of Rectangular');
subplot(2,5,8);
plot(w/pi, abs(h_ham));
xlabel('Radian frequency');
ylabel('Amplitude');
title('lin mag response of Hamming');

% group delay
subplot(2,5,4);
plot(w1, gd_rec);
xlabel('Radian frequency');
ylabel('Samples');
title('group delay of Rectangular');
subplot(2,5,9);
plot(w1, gd_ham);
xlabel('Radian frequency');
ylabel('Samples');
title('group delay of Hamming');

% pole-zero locations
subplot(2,5,5);
zplane(b_rec, 1);
title('pole zero plot of Rectangular');
subplot(2,5,10);
zplane(b_ham, 1);
title('pole zero plot of Hamming');
