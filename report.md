---
title: Estimation of Direction of Arrival Using Information Theory
author:
    - name: Aatmaram Yadav, Anupam Jakhar, Arpit Jangid,
    - name: Jayesh Kumar Gupta, Subhajit Mohanty
      affiliation: IIT Kanpur
date: Group 2
math: <script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
...

# Introduction

Time delay estimation (TDE) algorithms are popularly employed for the estimation of Direction of Arrival (DoA) of an acoustic source. The most popular approach relies on defining the relative delay between a pair of microphones by getting a peak in the comparing function at the correct DoA of the source.

The most common method applied for TDE is the generalized cross-correlation (GCC) algorithm with its numerous variants. But in reverberant environments its practical usefulness is severely restricted.

In our framework, we use the concept of mutual information to create a new comparing function that calculates the correct TDE by maximizing information that one microphone has about the other, assuming Gaussian distributions.

In the following sections, we describe the theory and implementation of this method and show the comparative results with (GCC-PHAT) in the result section as done in [1][^1].

# Theory

Our model consists of a two element microphone array positioned arbitrarily in some enclosure. Distance between the microphones is $d$ m. The sound source is assumed to be in the far field of the array so that it can be approximated as a plane wave arriving in a parallel manner at the microphones. For the non-reverberant case, signal at $m$th microphone (where $m = 1, 2$) :

(@) $$x_m(k) = s(k - \tau_m) + n_m(k)$$

where $\tau_m$ denotes the time samples that it takes for the source signal to reach the receiver $m$th microphone and $n_m(k)$ is the respective additive zero mean uncorrelated noise. The overall geometry can be seen in Fig. 1.

![Geometry of Recording System](./img/dir.png ) 

Using geometry we can find the following relation between DoA angle $\theta$ and delay $\tau$:

(@) $$\theta = \arcsin[\frac{\tau c}{f_s d}]$$ 

where $f_s$ is the sampling frequency, $c$ is the speed of sound.

## GCC-PHAT

The DoA is typically obtained using the original GCC function [^@knapp] or one of its variants. Here we use GCC-PHAT version, considered to be the most robust version [^@ward] $R(\tau)$ defined as cross correlation of $x_1$ and $x_2(\tau)$ filtered by a weighing function $g$ for the range of delays $\tau$ that determine the size of $L$. Considering their $L$-point discrete Fourier transforms,

(@) $$R(\tau) = \frac{1}{\pi} \sum_{\omega} = G(\omega) X_1(\omega) X_2^{*}(\omega; \tau) e^{j\omega \tau}$$, 
with

(@) $$G(\omega) = \frac{1}{|X_1(\omega)X_2^*(\omega; \tau)|}$$

$R(\tau)$ exhibits a global maximum at the lag value $\tau$. Therefore, we estimate $\tau_2$ by $\tau_2 = argmax_{\tau} R(\tau)$.

However to take the effect of reverberation into account, we use the following modal:

(@) $$x_m(k) = h_m(k) * s(k) + n_m(k)$$

where $h_m(k)$ represents the reverberant impulse response between the source and the $m$th microphone. Here $*$ represent convolution. This is a function of reverberation time, $T_{60}$.

## Information Theoretic Delay Estimation

Mutual information between signals $x_1$ and $x_2(\tau)$ is defined as [^@cover]:

(@mi) $$I = H[x_1] + H[x_2(\tau)] - H[x_1, x_2(\tau)]$$

where $H[x_m]$ is differential entropy of $x_m$ and $H[x_1, x_2(\tau)]$ is their joint entropy.

The problem of finding the delay is equivalent to finding the value of $\tau$ that maximizes (@mi). If we assume source signal to be zero mean Gaussian distributed, MI is equal to [^@cover]:

(@) $$I = - \frac{1}{2} ln\frac{\det[C(\tau)]}{C_{11}C_{22}}$$

For large L $C(\tau)$ can be approximated as

(@) $$C(\tau) \approx \begin{bmatrix} x_1 \\ x_2(\tau) \end{bmatrix} \begin{bmatrix} x_1 \\ x_2(\tau) \end{bmatrix}^T = \begin{bmatrix} C_{11} && C_{12}(\tau) \\ C_{21}(\tau) && C_{22}\end{bmatrix}$$

For reverberation model we find the marginal MI, considering jointly $N$ neighbouring samples:

(@mmi) $$I_N = - \frac{1}{2} ln\frac{\det[C(\tau)]}{det[C_{11}]det[C_{22}]}$$

Here $N$ is said to be the order of tracking system and the size of $C(\tau)$ is always $2(N+1) \times 2(N+1)$.

According to information theoretic criterion, when (@mmi) reaches a maximum as a function of $\tau$ at a specific time shift, then that's the required delay.

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

The data was divided into 10 frames, and for each frame an estimate $\hat{\tau}$ from which DoA is obtained. The squared error for frame $t$ is then obtained as:

(@) $$\sigma_t = (\tau - \hat{\tau_t})$$

The root mean-squared error (RMSE) metric is the performance measure used to evaluate the system. For a single displacement of the geometry, this is defined to be the square root of the average value of $\sigma_t$ over all frames. 


# Results

In the following figures we present the average RMSE over all ten simulation frames. Thus lower the average RMSE, better is the performance.

![RMSE vs. order N for different values of $T_{60}$. $L = 0.5 \times T_{60}f_s$](./img/plot1.png )

![RMSE of MI and GCC-PHAT systems for varying $T_{60}$. $L = 0.5 \times T_{60}f_s$](./img/plot2.png )

![RMSE of MI and GCC-PHAT systems for varying L](./img/plot3.png ) 

[^1]: F. Talantzis, A.G. Constantinides, L. Polymenakos, Estimation of direction of arrival using information theory, in: IEEE Signal Processing, 12 (8), August 2005, pp. 561–564.

[^@knapp]: C. H. Knapp and G. C. Carter, “The generalized correlation method for
estimation of time delay,” IEEE Trans. Acoust., Speech, Signal Process.,
vol. ASSP-24, no. 4, pp. 320–327, Aug. 1976.

[^@ward]: M. Brandstein and D. B. Ward, Microphone Arrays Signal Processing
Techniques and Applications.New York: Springer-Verlag, 2001.

[^@cover]: T. M. Cover and J. A. Thomas, Elements of Information Theory.New
York: Wiley, 1991.
    
