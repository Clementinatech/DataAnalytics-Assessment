    -- Customers with atleast one funded savings plan and one funded investment plans,sorted by total deposit
SELECT 
    u.id AS owner_id, concat(u.last_name, u.first_name) AS name,
    count(p.is_a_fund) AS investment_count, 
    count(p.is_regular_savings) AS savings_count,
    SUM(s.confirmed_amount) AS total_deposits
FROM users_customuser u
JOIN plans_plan p 
  ON u.id= p.owner_id
JOIN savings_savingsaccount s 
  ON p.id = s.plan_id
WHERE p.is_regular_savings >=1
  AND p.is_a_fund >=1
  AND s.confirmed_amount > 0
GROUP BY u.id, name
ORDER BY total_deposits DESC;

