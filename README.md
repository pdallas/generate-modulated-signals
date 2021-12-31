# generate-modulated-signals
This repository contains many simulations for wireless communications in MATLAB. It focuses on the modulation and demodulation of digital signals, that are effected by the variety and the randomness of the channel. 

## Functionality preview:

There are some basic functions, such as signal_mod and signal_demod, that can modulate/demodulate a bitstream given a modulation type (BPSK-QPSK-MPSK/MQAM/MPAM supported).

There are also some functions that help us calculate the Symbol Error Rate, based on the channel case. Those functions are ser_rayleigh and ser_rician. Moreover, there is implementation for Maximum-Likelihood detection for both Rayleigh and Rician channel cases. The most important scripts are the gen_mod_awgn_xxx ripts, which can be used in order to generate simulated training and testing datasets for Machine Learning models. 

An example figure is shown below:

![test](https://user-images.githubusercontent.com/64161512/147837490-c87b8b9b-bd00-4d0d-b359-7830ac170470.jpg)


An example figure that compares a trained Convolutional Neural Network (CNN) demodulator, a trained Recurrent Neural Network (RNN) demodulator and Maximum-Likelihood detection is given below:


![jjhjhjht_3](https://user-images.githubusercontent.com/64161512/147837558-1026fc76-4f23-44c2-9f34-e4e089be9db5.jpg)
