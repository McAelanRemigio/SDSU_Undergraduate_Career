## Attendance & Sentiment Analytics Pipeline (Conceptual)

### Overview
During my internship, I developed a repeatable process for collecting, cleaning, and analyzing attendance and post-event survey data to support program evaluation and resource allocation.

### Data Sources
- Event attendance records
- Post-event survey responses

### Processing Workflow
1. Data ingestion from attendance logs and survey exports
2. Cleaning and standardization of responses
3. Aggregation of attendance and sentiment metrics
4. Summary reporting for stakeholders

### Metrics Tracked
- Attendance volume and trends
- Sentiment indicators from survey responses
- Program-level engagement patterns

### Output
- Summary tables and reports used in decision-making discussions

## Future Implementation Notes

If rebuilding this system today, I would implement the pipeline using Python and SQL to improve scalability and automation.

### Potential Stack
- Python (pandas, numpy)
- SQL for structured storage
- Automated survey ingestion
- Scheduled reporting

### Improvements
- Reduced manual processing
- Version-controlled analysis
- Reproducible metrics across programs

## Pseudocode: Attendance & Sentiment Analysis

FOR each program:
    load attendance data
    load survey responses
    clean missing values
    compute attendance totals
    compute sentiment summary
    store results for reporting
