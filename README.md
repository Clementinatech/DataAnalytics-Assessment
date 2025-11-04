# DataAnalytics SQL Solution

## Overview
This repository contains SQL solutions to four data analytics questions.


## Question-by-Question Approach
###  Solution 1 – Cross-Selling Opportunity
**Approach:**  
- Joined the users_customuser, plans_plan and savings_savingsaccount tables to find users who have at least one funded savings plan (`is_regular_savings = 1`) and one funded investment plan (`is_a_fund = 1`).
- Aggregated by user and sorted by total deposit amounts to prioritize high-value customers.


### Solution 2 – Transaction Frequency Segmentation
**Approach:**  
Created a **subquery** that calculates the monthly transaction count per user using `YEAR()` and `MONTH()`.
- The outer query then computes the average monthly transaction count per user.
- Used a `CASE` statement to categorize customers into "High", "Medium", or "Low Frequency" groups based on average transaction volume.
- Grouped the final output by frequency category, with a count of customers and their average transaction volumes.


### Solution 3 – Inactive Accounts Detection
**Approach:**  
- Queried `plans_plan` and `savings_savingsaccount` to detect active accounts.
- Used an `INNER JOIN` clause to filter out plans that had any transactions within the last year.
- Calculated `last_transaction_date` and `inactivity_days` with `DATEDIFF()` for better context.


### Solution 4 – Customer Lifetime Value Estimation
**Approach:**  
- Calculated account tenure as the number of months since `date_joined` using `TIMESTAMPDIFF`.
- Counted total transactions from `savings_savingsaccount`.
- Used the provided CLV formula and assumed `0.1%` of transaction value as profit.
- Sorted customers by estimated CLV to prioritize high-value customers.

**Challenges**: 
- I encountered the challenge of comparing transaction dates to the current date (especially for Q3: Inactive Account Detection). I used the CURDATE() function with TIMESTAMPDIFF() to carry out date comparisons. This allowed me to calculate how many days have passed since the last inflow transaction for each account.
- In Assessment 4, I encountered a challenge of divide-by-zero errors for new users. I used `NULLIF` to safely calculate tenure-based averages.
