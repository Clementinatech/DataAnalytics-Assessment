-- average number of transactions per customer per month and categorize them
SELECT 
    t.user_id, t.name,
    AVG(t.monthly_txn_count) AS avg_transactions_per_month,
    CASE
        WHEN AVG(t.monthly_txn_count) >= 10 THEN 'High Frequency'
        WHEN AVG(t.monthly_txn_count) BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category
FROM (
    SELECT 
        u.id AS user_id,
        CONCAT(u.last_name,u.first_name) AS name,
        YEAR(s.transaction_date) AS txn_year,
        MONTH(s.transaction_date) AS txn_month,
        COUNT(s.transaction_reference) AS monthly_txn_count
    FROM users_customuser u
    JOIN savings_savingsaccount s ON u.id = s.owner_id
    GROUP BY u.id, YEAR(s.transaction_date), MONTH(s.transaction_date)
) AS t
GROUP BY user_id, name;


-- the average number of transactions per month by customer_count
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 2) AS avg_txn_per_customer
FROM (
    SELECT 
        t.user_id,
        AVG(t.monthly_txn_count) AS avg_transactions_per_month,
        CASE
            WHEN AVG(t.monthly_txn_count) >= 10 THEN 'High Frequency'
            WHEN AVG(t.monthly_txn_count) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM (
        SELECT 
            u.id AS user_id,
            YEAR(s.transaction_date) AS txn_year,
            MONTH(s.transaction_date) AS txn_month,
            COUNT(s.transaction_reference) AS monthly_txn_count
        FROM users_customuser u
        JOIN savings_savingsaccount s ON u.id = s.owner_id
        GROUP BY u.id, YEAR(s.transaction_date), MONTH(s.transaction_date)
    ) AS t
    GROUP BY t.user_id
) AS freq_summary
GROUP BY frequency_category;

