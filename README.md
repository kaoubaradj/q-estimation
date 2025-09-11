\# q-estimation MATLAB Functions



This repository contains MATLAB functions developed as part of my research work on \*\*q-estimation methods\*\* for distributions, including the Lindley q-distribution.



---



\## 📌 Functions



\- \*\*estimate\_theta\_qLindley(sample, max\_intervals, q)\*\*  

&nbsp; Estimates parameter θ of the Lindley q-distribution.



\- \*\*main\_lindley\_q\_experiment()\*\*  

&nbsp; Runs the full experiment: estimates `c`, computes empirical q-moments, and compares with theory.



\- \*\*estimate\_c\_lindley\_q(samples, theta, numBins, q)\*\*  

&nbsp; Estimates scaling constant `c` by comparing histogram density with theoretical PDF.



\- \*\*sample\_lindley\_q(q\_theta, len, height, num\_samples, q)\*\*  

&nbsp; Generates random samples from the Lindley q-distribution using acceptance-rejection.



\- \*\*Helper functions\*\*: `q\_number`, `q\_expo2`, `q\_factorial`.



---



\## 🚀 Quick Start



After cloning this repository, you can quickly test the functions by running the demo script:



```matlab

% In MATLAB:

addpath('functions');             % Add function folder to path

run('examples/demo\_run.m');       % Run the demonstration



