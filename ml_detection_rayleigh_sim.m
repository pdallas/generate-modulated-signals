% Maximum Likelihood Detection Simulation
% Energy of a single constellation E = Vi^2+Vq^2
% For M constellation points, the total energy is Etotal = for j=1:M,
% sum(Vij^2+Vqj^2)
rng default;
MOD_TYPE = 'QAM';
EbN0dB = -5:1:15;
% Number of transmitted symbols
nSym = 10^6;
% Modulation order
M = 16;
% Bits per symbol
k = log2(M);
% EsN0dB calculation
EsN0dB = 10*log10(k)+EbN0dB;
% Uniform random symbols from 1:M
d=floor(M.*rand(1,nSym));
s = signal_mod(MOD_TYPE,M,d);
% Find the constellation points of the selected Modulation scheme
c = unique(s);
% scatterplot(s, [],[],'r*'); hold on;
for i=1:length(EsN0dB)
        % Flat Rayleigh
        h = 1/sqrt(2)*(randn(1,nSym)+1i*randn(1,nSym));
        % Flat fading effect on the modulated symbols
        hs = abs(h).*s;
        % Additive Gaussian white noise
        r = add_awgn(hs,EsN0dB(i));
        % Possible transmitted symbols 
        tranSymb = c;
        det = [];
        % -------------------- Reciever ---------------------
        % Decision vector
        y = r./abs(h);
        % Initialize real-time counter
        tic;
        % For each symbol;
        for mm=1:length(y)
            % Calculate the Euclidian distance for every possible
            % constellation
            for nn=1:length(tranSymb)
                a = (real(y(mm))-real(tranSymb(nn)))^2;
                b = (imag(y(mm))-imag(tranSymb(nn)))^2;
                % Assign each Euclidian distance 
                % into a variable
                err(nn)=sqrt(a+b);               
            end
            % Find the minimum distance of each symbol and assign it into a
            % variable
            iden = tranSymb(find(err==min(err)));
            det = [det iden];
        end
        % Stop the time and assign its value to a variable
        timeElapsed = toc;
        % Create an array to save the time it took to classify all the
        % symbols for each EsN0dB value
        time_arr(i) = timeElapsed;
        % Create and display a message
        msg = ["Total time to classify 10^6 symbols is ;",num2str(timeElapsed)," seconds."];
        disp(msg);
        % Calculate the Symbol Error Rate
        SER_ML(i) = sum(s~=det)/length(s);
end
% Plotting section
semilogy(EbN0dB,SER_ML,'r'); hold on; grid on;



