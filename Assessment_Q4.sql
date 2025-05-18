-- CLV estimate based on account tenure and transaction volume
SELECT 
    u.id AS customer_id,
    CONCAT(u.last_name,u.first_name) AS name,
    -- Calculate account tenure in months since the customer joined
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    
    -- Total number of transactions by customer
    COUNT(s.id) AS total_transactions,

    -- Estimate CLV using formula: (transactions per month) * 12 * profit per transaction (0.1%)
    ROUND(((COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) * 12 * 0.001), 2) AS estimated_clv
FROM users_customuser u
JOIN savings_savingsaccount s 
    ON u.id = s.owner_id
GROUP BY u.id, u.name, u.date_joined
ORDER BY estimated_clv DESC;
