% Estimation of Direction of Arrival Using Information Theory
% Aatmaram Yadav;
  Anupam Jakhar;
  Arpit Jangid;
  Jayesh Kumar Gupta;
  Subhajit Mohanty
% Group 2

# Introduction

Time delay estimation (TDE) algorithms are popularly employed for the estimation of Direction of Arrival (DoA) of an acoustic source. The most popular approach relies on defining the relative delay between a pair of microphones by getting a peak in the comparing function at the correct DoA of the source.

The most common method applied for TDE is the generalized cross-correlation (GCC) algorithm with its numerous variants. But in reverberant environments its practical usefulness is severely restricted.

In our framework, we use the concept of mutual information to create a new comparing function that calculates the correct TDE by maximizing information that one microphone has about the other, assuming Gaussian distributions.

In the following sections, we describe the theory and implementation of this method and show the comparative results with (GCC-PHAT) in the result section.

# Theory

Our model consists of a two element microphone array positioned arbitrarily in some enclosure. Distance between the microphones is $d$ m. The sound source is assumed to be in the far field of the array so that it can be approximated as a plane wave arriving in a parallel manner at the microphones. For the non-reverberant case, signal at $m$th microphone (where $m = 1, 2$) :

(@) $$x_m(k) = s(k - \tau_m) + n_m(k)$$

where $\tau_m$ denotes the time samples that it takes for the source signal to reach the receiver $m$th microphone and $n_(k)$ is the respective additive zero mean uncorrelated noise. The overall geometry can be seen in Fig. 1.

![Geometry of Recording System](./dir.png ) 

Using geometry we can find the following relation between DoA angle $\theta$ and delay $\tau$:

(@) $$\theta = \arcsin[\frac{\tau c}{f_s d}]$$ 

where $f_s$ is the sampling frequency, $c$ is the speed of sound.

## GCC-PHAT

The DoA is typically obtained using the original GCC function ^[@knapp] or one of its variants. Here we use GCC-PHAT version, considered to be the most robust version ^[@ward] $R(\tau)$ defined as cross correlation of $x_1$ and $x_2(\tau)$ filtered by a weighing function $g$ for the range of delays $\tau$ that determine the size of $L$. Considering their $L$-point discrete Fourier transforms,

(@) $$R(\tau) = \frac{1}{\pi} \sum_{\omega} = G(\omega) X_1(\omega) X_2^{*}(\omega; \tau) e^{j\omega \tau}$$

with

(@) $$G(\omega) = \frac{1}{|X_1(\omega)X_2^*(\omega; \tau)|}$$

$R(\tau)$ exhibits a global maximum at the lag value $\tau$. Therefore, we estimate $\tau_2$ by $\tau_2 = argmax_{\tau} R(\tau)$.

However to take the effect of reverberation into account, we use the following modal:

(@) $$x_m(k) = h_m(k) * s(k) + n_m(k)$$

where $h_m(k)$ represents the reverberant impulse response between the source and the $m$th microphone. Here $*$ represent convolution. This is a function of reverberation time, $T_{60}$.

## Information Theoretic Delay Estimation



# Implementation

Simulations involved a single source and two microphone system. The relative sample delay estimate varies according to $d$. Moreover, the system can find only integer delays, so optimally it should estimate the delay to the nearest integer.

--------------                 ------------------------
Variable                       Value
--------------                 ------------------------
Speech duration                5 s

Sampling Frequency, $f_s$      44.1 kHz

Distance between source        2.23
& mid-point of receivers
Actual delay (samples)         6.89

Expected delay (samples)       7

$T_{60}(s)$                    0.15, 0.30, 0.50

Length of $h(k)$ (samples)     6615, 13230, 22050

Room dimensions                [5 4 3] m

Noise added                    15 dB
--------------------------     ------------------------



# Results
