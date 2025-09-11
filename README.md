## Functions Overview

### `estimate_theta_qLindley(sample, max_intervals, q)`
Estimates the parameter **θ** of the Lindley q-distribution.

---

### `main_lindley_q_experiment()`
Runs the full experiment:
- Estimates scaling constant **c**
- Computes novel empirical q-moments
- Compares results with theoretical values

---

### `estimate_c_lindley_q(samples, theta, numBins, q)`
Estimates scaling constant **c** by comparing histogram density with the theoretical PDF.

---

### `sample_lindley_q(q_theta, len, height, num_samples, q)`
Generates random samples from the Lindley q-distribution using **acceptance-rejection** sampling.

---

### `plot_q_histogram(samples, q, max_intervals)`
Computes q-based intervals, calculates the percentage of data points in each interval, and plots a labeled histogram.  This function is primarily useful for determining an appropriate value for max_intervals.


---

**Parameters:**
- **q_theta** → q-analog of the real number θ  
- **len** → range of the distribution  
  - For first-kind continuous q-distributions: finite  
  - For second-kind: normally infinite (but can be truncated by cutting off the negligible tail)  
- **height** → maximum value of the PDF over its range  
- **num_samples** → sample size to generate  

---

### Helper Functions
- `q_number`
- `q_expo2`
- `q_factorial`
