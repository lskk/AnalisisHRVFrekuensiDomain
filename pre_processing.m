function [ freq, pow ] = pre_processing( txt_file, plot_on )

%frequency sampling
fs = 1;
fmax = fs/2;

%read text file (data input / RR Interval)
D = dlmread(txt_file);

%convert to ms
S = D*1000;
A = mean(S(:));
R = (S()-A);

N = length(R);

%hanning
fn = hanning(N);
fhan = R.*fn;

C = 2^nextpow2(N);

%fft
Y = fft(fhan,C)/N;
Z = abs(Y);
Y = Z(1:N);

%power spectrum
pow = (1/(fs*N))* abs(Y).^2;
pow(2:end-1) = 2*pow(2:end-1);
freq = 0:fs/length(S):fs;

if(plot_on)
    plot(freq, pow);
    grid on
    title('PSD Estimate using FFT')
    xlabel ('Frequency (Hz)')
    ylabel ('Power Spectrum ')
end


end

