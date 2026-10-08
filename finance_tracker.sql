-- Personal Finance Tracker
-- Author: Joshua Awogbami

CREATE TABLE transactions (
    id INTEGER PRIMARY KEY,
    date DATE,
    category TEXT,
    description TEXT,
    amount DECIMAL(10, 2),
    type TEXT
);

INSERT INTO transactions VALUES (1, '2026-10-11', 'income', 'Part time paycheck', 498.69, 'income');
INSERT INTO transactions VALUES (2, '2026-10-11', 'tithe', 'Church offering', 64.00, 'expense');
INSERT INTO transactions VALUES (3, '2026-10-11', 'fitness', 'Planet Fitness Black Card', 13.00, 'expense');
INSERT INTO transactions VALUES (4, '2026-10-11', 'subscriptions', 'iPhone 18 Pro installment', 38.89, 'expense');
INSERT INTO transactions VALUES (5, '2026-10-11', 'subscriptions', 'PS Plus Essential', 9.99, 'expense');
INSERT INTO transactions VALUES (6, '2026-10-11', 'subscriptions', 'Apple Music Student', 5.99, 'expense');
INSERT INTO transactions VALUES (7, '2026-10-11', 'investing', 'Fidelity S&P 500', 70.00, 'expense');
INSERT INTO transactions VALUES (8, '2026-10-11', 'savings', 'HYSA deposit', 70.00, 'expense');
INSERT INTO transactions VALUES (9, '2026-10-13', 'food', 'Chipotle', 15.00, 'expense');
INSERT INTO transactions VALUES (10, '2026-10-15', 'food', 'Chick-fil-A', 15.00, 'expense');
INSERT INTO transactions VALUES (11, '2026-10-17', 'food', 'Chipotle', 15.00, 'expense');
INSERT INTO transactions VALUES (12, '2026-10-19', 'food', 'Chick-fil-A', 15.00, 'expense');
INSERT INTO transactions VALUES (13, '2026-10-25', 'income', 'Part time paycheck', 498.69, 'income');
INSERT INTO transactions VALUES (14, '2026-10-25', 'tithe', 'Church offering', 64.00, 'expense');
INSERT INTO transactions VALUES (15, '2026-10-25', 'fitness', 'Planet Fitness Black Card', 13.00, 'expense');
INSERT INTO transactions VALUES (16, '2026-10-25', 'subscriptions', 'iPhone 18 Pro installment', 38.89, 'expense');
INSERT INTO transactions VALUES (17, '2026-10-25', 'subscriptions', 'PS Plus Essential', 9.99, 'expense');
INSERT INTO transactions VALUES (18, '2026-10-25', 'subscriptions', 'Apple Music Student', 5.99, 'expense');
INSERT INTO transactions VALUES (19, '2026-10-25', 'investing', 'Fidelity S&P 500', 70.00, 'expense');
INSERT INTO transactions VALUES (20, '2026-10-25', 'savings', 'HYSA deposit', 70.00, 'expense');
INSERT INTO transactions VALUES (21, '2026-10-27', 'food', 'Chipotle', 15.00, 'expense');
INSERT INTO transactions VALUES (22, '2026-10-29', 'food', 'Chick-fil-A', 15.00, 'expense');
INSERT INTO transactions VALUES (23, '2026-10-31', 'food', 'Chipotle', 15.00, 'expense');
INSERT INTO transactions VALUES (24, '2026-10-31', 'grooming', 'Haircut (me and lil bro)', 35.00, 'expense');

SELECT SUM(amount) AS total_income
FROM transactions
WHERE type = 'income';

SELECT SUM(amount) AS total_expenses
FROM transactions
WHERE type = 'expense';

SELECT category, SUM(amount) AS total
FROM transactions
WHERE type = 'expense'
GROUP BY category
ORDER BY total DESC;
