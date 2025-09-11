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

### Helper Functions
- `q_number`
- `q_expo2`
- `q_factorial`
