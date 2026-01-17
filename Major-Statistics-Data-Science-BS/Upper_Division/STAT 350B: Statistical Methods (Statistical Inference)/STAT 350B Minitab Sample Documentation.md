# STAT 350B — Applied Regression Modeling Example

I wrote this document based on a project where I applied multiple regression analysis as part of STAT 350B using Minitab. Rather than focusing on how I used the software itself, I focus here on **statistical reasoning, model diagnostics, and interpretation**, which were the most important parts of the project.

---

## Problem Context

The goal of this analysis was to model **sulfur dioxide concentration** in cities using a combination of environmental and demographic predictors. Candidate explanatory variables included measures related to population, industrial activity, temperature, wind speed, and precipitation.

In this project, I had to evaluate model assumptions, diagnose issues, and refine multiple models to improve both interpretability and validity.

---

## Initial Model Assessment

### Multicollinearity

When I first examined correlations between predictors, I noticed a **strong linear relationship** between the number of manufacturing enterprises (ENTERP) and population size (POPN), which immediately raised concerns about multicollinearity.

I confirmed this using **Variance Inflation Factors (VIFs)**, where both variables exceeded common thresholds for concern. This indicated that multicollinearity was present and motivated changes to variable inclusion and transformation strategies.

---

## Model Diagnostics

### Nonlinearity and Assumption Violations

Matrix plots comparing predictors to sulfur concentration showed **nonlinear relationships** between several explanatory variables and the response.

Residual diagnostics further revealed:
- Deviations from normality in the residual distribution
- Patterns suggesting **non-constant variance**

Together, these results indicated that the assumptions of the classical linear regression model were not fully satisfied.

---

## Model Refinement

### Transformations

To address these issues, I applied transformations to selected variables to improve linearity and residual behavior, including:
- Logarithmic transformations
- Reciprocal (1/x) transformations

---

### Model Selection

I used best subsets regression to compare competing models based on:
- Overall \(R^2\)
- Adjusted \(R^2\)
- Mallows’ \(C_p\)

Based on these criteria, I selected a model with **five predictors** due to its relatively high adjusted \(R^2\), Mallows’ \(C_p\) close to the number of predictors, and a reasonable balance between explanatory power and model simplicity.

---

## Outliers and Influence

### Influential Observations

Influence diagnostics identified observations with:
- High leverage
- Large Cook’s Distance values
- Large DFFITS values

I compared models **with and without** these influential observations. While removing them slightly reduced \(R^2\), it improved coefficient stability and statistical significance for certain predictors. This comparison highlighted the importance of influence diagnostics in applied regression analysis.

---

## Interpretation and Inference

I used the final model to:
- Interpret regression coefficients in context
- Construct **confidence intervals** for mean sulfur concentration
- Construct **prediction intervals** for sulfur concentration in a specific city

These results highlighted the difference between uncertainty in the mean response and uncertainty in individual predictions.

---

## Key Takeaways

This project reinforced several core concepts from STAT 350B:

- Detecting and addressing multicollinearity
- Using diagnostic plots to assess model assumptions
- Applying transformations to improve model validity
- Selecting models using multiple quantitative criteria
- Evaluating the impact of influential observations
- Interpreting regression results in applied contexts

Overall, this project showed me that effective regression modeling requires **iterative refinement and statistical judgment**, not just fitting a single model.
