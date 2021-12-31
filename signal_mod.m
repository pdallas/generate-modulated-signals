% The following function modulates a singal, based on the modulation type.
% Supported modulations/MOD_TYPE; BPSK-QPSK-MPSK/MQAM/MPAM (FSK not supported)
% M; Modulation/Demodulated order
% y; Transmitted modulated signal
% https://nl.mathworks.com/help/comm/modulation.html?s_tid=CRUX_lftnav
function [modulated_signal] = signal_mod(MOD_TYPE,M,x)

switch lower(MOD_TYPE)
    case {'bpsk'}   
        bpskmod = comm.BPSKModulator;
        bpskmod.PhaseOffset = 0;
        modulated_signal = bpskmod(x','PlotConstellation',true);
    case {'qpsk','mpsk','psk'}
        modulated_signal = pskmod(x,M,'PlotConstellation',true);
    case {'mqam','qam'}
       modulated_signal = qammod(x,M);
    case {'mpam','pam'}
        init_phase = pi/4;
        modulated_signal = pammod(x,M,init_phase,'PlotConstellation',true);
    otherwise
        disp 'singal_mod.m: Invalid modulation (MOD_TYPE) selected.'
end
end