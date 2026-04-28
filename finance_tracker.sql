-- Personal Finance Tracker
-- Author: Joshua Awogbami

-- Create transactions table
CREATE TABLE transactions (
    id INTEGER PRIMARY KEY,
    date DATE,
    category TEXT,
    description TEXT,
    amount DECIMAL(10, 2),
    type TEXT -- 'income' or 'expense'
);

-- Sample data
INSERT INTO transactions VALUES (1, '2026-05-01', 'Food', 'Groceries', 85.00, 'expense');
INSERT INTO transactions VALUES (2, '2026-05-01', 'Income', 'Paycheck', 500.00, 'income');
INSERT INTO transactions VALUES (3, '2026-05-02', 'Transport', 'Gas', 40.00, 'expense');
INSERT INTO transactions VALUES (4, '2026-05-03', 'Tithe', 'Church offering', 50.00, 'expense');
INSERT INTO transactions VALUES (5, '2026-05-03', 'Savings', 'MacBook fund', 100.00, 'expense');

-- Total income
SELECT SUM(amount) AS total_income 
FROM transactions 
WHERE type = 'income';

-- Total expenses
SELECT SUM(amount) AS total_expenses 
FROM transactions 
WHERE type = 'expense';

-- Spending by category
SELECT category, SUM(amount) AS total 
FROM transactions 
WHERE type = 'expense'
GROUP BY category
ORDER BY total DESC;
