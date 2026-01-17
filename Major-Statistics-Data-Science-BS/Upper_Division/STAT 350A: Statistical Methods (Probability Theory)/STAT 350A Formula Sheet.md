# STAT 350A — Probability & Inference Formula Sheet

This document is a concise reference of core probability and inference formulas covered in STAT 350A.  
It is intended for long-term reuse and conceptual recall rather than step-by-step instruction.

---

## One-Sample Proportion

### Parameter & Estimate
- Population proportion: $\pi$
- Sample proportion: $\hat{\pi} = \frac{x}{n}$

### Test Statistic
$$
z = \frac{\hat{\pi} - \pi_0}{\sqrt{\frac{\pi_0(1-\pi_0)}{n}}}
$$

### Distribution
$$
Z \sim N(0,1)
$$

### Confidence Interval
$$
\hat{\pi} \pm z_{\alpha/2}\sqrt{\frac{\hat{\pi}(1-\hat{\pi})}{n}}
$$

### Assumptions
- Random sample
- Independent trials
- $n\hat{\pi} > 5$ and $n(1-\hat{\pi}) > 5$

---

## Two-Sample Proportions

### Parameter & Estimate
- Population proportions: $\pi_1, \pi_2$
- Sample proportions: $\hat{\pi}_1, \hat{\pi}_2$

### Test Statistic
$$
z = \frac{(\hat{\pi}_1 - \hat{\pi}_2) - D_0}
{\sqrt{\hat{\pi}_1(1-\hat{\pi}_1)/n_1 + \hat{\pi}_2(1-\hat{\pi}_2)/n_2}}
$$

### Distribution
$$
Z \sim N(0,1)
$$

### Assumptions
- Independent samples
- Random sampling
- $n_i\hat{\pi}_i > 5$ and $n_i(1-\hat{\pi}_i) > 5$, for $i = 1,2$

---

## One-Sample Mean (σ Known)

### Parameter & Estimate
- Population mean: $\mu$
- Sample mean: $\bar{y}$

### Test Statistic
$$
z = \frac{\bar{y} - \mu_0}{\sigma / \sqrt{n}}
$$

### Distribution
$$
Z \sim N(0,1)
$$

### Confidence Interval
$$
\bar{y} \pm z_{\alpha/2}\frac{\sigma}{\sqrt{n}}
$$

### Assumptions
- Population is normal **or** sample size $n \ge 30$

---

## Two-Sample Means (σ Unknown)

### Parameter & Estimate
- Population means: $\mu_1, \mu_2$
- Sample means: $\bar{y}_1, \bar{y}_2$

### Pooled Standard Deviation
$$
s_p = \sqrt{\frac{(n_1-1)s_1^2 + (n_2-1)s_2^2}{n_1 + n_2 - 2}}
$$

### Test Statistic
$$
t = \frac{(\bar{y}_1 - \bar{y}_2) - D_0}
{s_p\sqrt{\frac{1}{n_1} + \frac{1}{n_2}}}
$$

### Distribution
$$
T \sim t(n_1 + n_2 - 2)
$$

---

## Paired t-Test

### Differences
$$
d_i = y_{1i} - y_{2i}
$$

### Test Statistic
$$
t = \frac{\bar{d} - D_0}{s_d / \sqrt{n}}
$$

### Distribution
$$
T \sim t(n - 1)
$$

### Assumptions
- Paired observations
- Differences are independent
- Differences are approximately normal or $n \ge 30$

---

## Chi-Square Tests

### Test Statistic
$$
\chi^2 = \sum \frac{(O_i - E_i)^2}{E_i}
$$

### Degrees of Freedom

| Test Type | Degrees of Freedom |
|----------|-------------------|
| Goodness of Fit | $k - 1$ |
| Independence | $(r-1)(c-1)$ |

### Distribution
$$
\chi^2 \sim \chi^2(df)
$$

---

## Simple Linear Regression

### Coefficients
$$
\hat{\beta}_1 = \frac{S_{xy}}{S_{xx}}, \quad
\hat{\beta}_0 = \bar{y} - \hat{\beta}_1\bar{x}
$$

Where:
$$
S_{xx} = \sum (x_i - \bar{x})^2, \quad
S_{xy} = \sum (x_i - \bar{x})(y_i - \bar{y})
$$

### Regression Line
$$
\hat{y} = \hat{\beta}_0 + \hat{\beta}_1 x
$$

---

## Sample Size & Margin of Error

### For Proportions
$$
n = \frac{z_{\alpha/2}^2 \hat{\pi}(1-\hat{\pi})}{MOE^2}
$$

### For Means
$$
n = \left(\frac{z_{\alpha/2}\sigma}{MOE}\right)^2
$$

---

## Common Critical Values

| Confidence Level | $z_{\alpha/2}$ |
|-----------------|---------------|
| 90% | 1.645 |
| 95% | 1.96 |
| 99% | 2.576 |
