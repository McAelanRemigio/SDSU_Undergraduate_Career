# STAT 350B — Applied Statistical Modeling Formula Sheet

---

## One-Way ANOVA

### Notation
- $t$: number of groups
- $n_i$: sample size for group $i$
- $\bar{y}_i$: sample mean for group $i$
- $\bar{y}$: overall (grand) mean
- $N = \sum_{i=1}^{t} n_i$: total sample size

### Sums of Squares
$$
SSB = \sum_{i=1}^{t} n_i(\bar{y}_i - \bar{y})^2
$$

$$
SSW = \sum_{i=1}^{t} \sum_{j=1}^{n_i} (y_{ij} - \bar{y}_i)^2
$$

$$
SST = SSB + SSW
$$

### Test Statistic
$$
F = \frac{SSB/(t-1)}{SSW/(N-t)}
$$

### Distribution
$$
F \sim F(t-1, N-t)
$$

### Assumptions
- Independent random samples
- Normal populations or large sample sizes
- Equal population variances

---

## Multiple Linear Regression

### Model
$$
y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + \cdots + \beta_k x_k + \varepsilon
$$

Where:
- $\varepsilon \sim N(0, \sigma^2)$
- Errors are independent

### Estimated Regression Equation
$$
\hat{y} = \hat{\beta}_0 + \hat{\beta}_1 x_1 + \cdots + \hat{\beta}_k x_k
$$

---

## Variation Decomposition

$$
SST = SSR + SSE
$$

Where:
- $SSR$: explained (regression) sum of squares
- $SSE$: unexplained (error) sum of squares

### Coefficient of Determination
$$
R^2 = \frac{SSR}{SST}
$$

### Adjusted $R^2$
$$
R^2_{\text{adj}} = 1 - \frac{SSE/(n-k-1)}{SST/(n-1)}
$$

---

## Model Selection Criteria

### Mean Squared Error
$$
MSE = \frac{SSE}{n-k-1}
$$

### Mallows’ $C_p$
$$
C_p = \frac{SSE_p}{MSE} - (n - 2p)
$$

Where:
- $p$: number of predictors in the model

### Selection Principles
- Prefer models with higher adjusted $R^2$
- Prefer models with smaller $C_p$ close to $p+1$
- Balance model fit with parsimony

---

## Residual Analysis

### Residuals
$$
e_i = y_i - \hat{y}_i
$$

### Diagnostics
- Residuals vs fitted values (linearity, constant variance)
- Normal probability plot (normality)
- Residuals vs predictors (functional form)

---

## Transformations

### Common Transformations
- Log: $\log(y)$ or $\log(x)$
- Square root: $\sqrt{y}$
- Reciprocal: $1/y$

### Purpose
- Address nonlinearity
- Stabilize variance
- Improve normality of residuals

---

## Outliers and Influence

### Leverage
$$
h_{ii} = x_i^T (X^T X)^{-1} x_i
$$

High leverage if:

$$
h_{ii} > \frac{2(k+1)}{n}
$$


### Cook’s Distance
$$
D_i = \frac{(\hat{\beta} - \hat{\beta}_{(i)})^T X^T X (\hat{\beta} - \hat{\beta}_{(i)})}{(k+1)MSE}
$$

### DFFITS
$$
DFFITS_i = \frac{\hat{y}_i - \hat{y}_{(i)}}{s_{(i)}\sqrt{h_{ii}}}
$$

### DFBETAS
$$
DFBETAS_{ij} = \frac{\hat{\beta}_j - \hat{\beta}_{j(i)}}{SE(\hat{\beta}_j)}
$$

---

## Multicollinearity

### Variance Inflation Factor
$$
VIF_j = \frac{1}{1 - R_j^2}
$$

Where:
- $R_j^2$ is obtained by regressing $x_j$ on all other predictors

### Interpretation
- $VIF \approx 1$: no collinearity
- $VIF > 5$: moderate collinearity
- $VIF > 10$: severe collinearity

---

## Model Building Workflow (Summary)

- Explore data visually and numerically
- Fit initial regression model
- Check residual diagnostics
- Assess transformations if needed
- Evaluate outliers and influential points
- Examine multicollinearity
- Refine model using selection criteria
