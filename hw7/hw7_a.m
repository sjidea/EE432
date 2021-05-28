clc; clear;
%% given specification
Wp = 0.3*pi; % passband edge frequency (rad/sec)
Ws = 0.4*pi; % stopband edge frequency (rad/sec)
Rp = 0.2;     % max passband attenuation (dB)
Rs = 20;    % max stopband attenuation (dB)
%% analog filter
n = cheb1ord( Wp/pi, Ws/pi, Rp, Rs); % lowest order n
[b, a] = cheby1( n, Rp, Wp, 's'); % Hc(s) = B(s)/A(s)

%% digital filter
[bz_iiv, az_iiv] = impinvar(b,a,1); %fs = 1/Td = 1
[bz_bil, az_bil] = bilinear(b,a,1);

% frequency response
w = 0:pi/100:pi;
h_iiv = freqz(bz_iiv, az_iiv, w);   % discrete: freq'z' 
h_bil = freqz(bz_bil, az_bil, w);

%group delay
gd_iiv = grpdelay(bz_iiv, az_iiv, w);
gd_bil = grpdelay(bz_bil, az_bil, w);


%% plot LPF
f1 = figure('Name', 'Chebyshev Type 1 LPF', 'NumberTitle', 'off');

% magnitude in dB = 20*log10(abs(h))
subplot(2,4,1);
plot(w, 20*log10(abs(h_iiv)));
xlabel('Radian frequency');
xticks([0:0.2*pi:pi]);
xticklabels({'0', '0.2\pi', '0.4\pi', '0.6\pi', '0.8\pi', '\pi'});
ylabel('dB');
title('magnitude response in dB of IIV');
subplot(2,4,5);
plot(w, 20*log10(abs(h_bil)));
xlabel('Radian frequency');
xticks([0:0.2*pi:pi]);
xticklabels({'0', '0.2\pi', '0.4\pi', '0.6\pi', '0.8\pi', '\pi'});
ylabel('dB');
title('magnitude response in dB of BT');

% magnitude linear = abs(h)
subplot(2,4,2);
plot(w, abs( h_iiv));
xlabel('Radian frequency');
xticks([0:0.2*pi:pi]);
xticklabels({'0', '0.2\pi', '0.4\pi', '0.6\pi', '0.8\pi', '\pi'});
ylabel('Amplitude');
title('magnitude response linear of IIV');
subplot(2,4,6);
plot(w, abs( h_bil));
xlabel('Radian frequency');
xticks([0:0.2*pi:pi]);
xticklabels({'0', '0.2\pi', '0.4\pi', '0.6\pi', '0.8\pi', '\pi'});
ylabel('Amplitude');
title('magnitude response linear of BT');

% group delay
subplot(2,4,3);
plot(w, gd_iiv);
xlabel('Radian frequency');
xticks([0:0.2*pi:pi]);
xticklabels({'0', '0.2\pi', '0.4\pi', '0.6\pi', '0.8\pi', '\pi'});
ylabel('Samples');
title('group delay of IIV');
subplot(2,4,7);
plot(w, gd_bil);
xlabel('Radian frequency');
xticks([0:0.2*pi:pi]);
xticklabels({'0', '0.2\pi', '0.4\pi', '0.6\pi', '0.8\pi', '\pi'});
ylabel('Samples');
title('group delay of BT');

% pole zero
subplot(2,4,4);
zplane(bz_iiv, az_iiv);
title('pole zero plot of IIV');
subplot(2,4,8);
zplane(bz_bil, az_bil);
title('pole zero plot of BT');

%% plot analog
h = freqs(b, a, w);   % analog: freq's'
f2 = figure('Name', 'Chebyshev Type 1 LPF ANALOG', 'NumberTitle', 'off');
plot(w, 20*log10(abs(h)));
xlabel('Radian frequency');
xticks([0:0.2*pi:pi]);
xticklabels({'0', '0.2\pi', '0.4\pi', '0.6\pi', '0.8\pi', '\pi'});
ylabel('dB');
title('magnitude response in dB');
