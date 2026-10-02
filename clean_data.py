import csv
from datetime import datetime

RAW_PATH = "raw_transactions.csv"
CLEAN_CSV_PATH = "clean_transactions.csv"
SQL_PATH = "finance_tracker_updated.sql"


def parse_date(raw):
    raw = raw.strip()
    for fmt in ("%m/%d/%Y", "%Y-%m-%d"):
        try:
            return datetime.strptime(raw, fmt).date().isoformat()
        except ValueError:
            continue
    raise ValueError(f"Unrecognized date format: {raw}")


def clean_rows(rows):
    seen = set()
    cleaned = []
    for row in rows:
        amount = row["amount"].strip()
        if not amount:
            continue  # skip rows with missing amount

        date = parse_date(row["date"])
        category = row["category"].strip().title()
        description = row["description"].strip()
        amount = float(amount)
        txn_type = row["type"].strip().lower()

        key = (date, category, description, amount, txn_type)
        if key in seen:
            continue  # skip exact duplicates
        seen.add(key)

        cleaned.append({
            "date": date,
            "category": category,
            "description": description,
            "amount": amount,
            "type": txn_type,
        })
    return cleaned


def write_clean_csv(cleaned):
    with open(CLEAN_CSV_PATH, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["id", "date", "category", "description", "amount", "type"])
        writer.writeheader()
        for i, row in enumerate(cleaned, start=1):
            writer.writerow({"id": i, **row})


def write_sql(cleaned):
    lines = []
    lines.append("-- Personal Finance Tracker")
    lines.append("-- Author: Joshua Awogbami")
    lines.append("")
    lines.append("-- Create transactions table")
    lines.append("CREATE TABLE transactions (")
    lines.append("    id INTEGER PRIMARY KEY,")
    lines.append("    date DATE,")
    lines.append("    category TEXT,")
    lines.append("    description TEXT,")
    lines.append("    amount DECIMAL(10, 2),")
    lines.append("    type TEXT -- 'income' or 'expense'")
    lines.append(");")
    lines.append("")
    lines.append("-- Cleaned transaction data (loaded via Python data-cleaning pipeline)")
    for i, row in enumerate(cleaned, start=1):
        lines.append(
            "INSERT INTO transactions VALUES ({}, '{}', '{}', '{}', {:.2f}, '{}');".format(
                i, row["date"], row["category"], row["description"].replace("'", "''"), row["amount"], row["type"]
            )
        )
    lines.append("")
    lines.append("-- Total income")
    lines.append("SELECT SUM(amount) AS total_income")
    lines.append("FROM transactions")
    lines.append("WHERE type = 'income';")
    lines.append("")
    lines.append("-- Total expenses")
    lines.append("SELECT SUM(amount) AS total_expenses")
    lines.append("FROM transactions")
    lines.append("WHERE type = 'expense';")
    lines.append("")
    lines.append("-- Spending by category")
    lines.append("SELECT category, SUM(amount) AS total")
    lines.append("FROM transactions")
    lines.append("WHERE type = 'expense'")
    lines.append("GROUP BY category")
    lines.append("ORDER BY total DESC;")
    lines.append("")
    with open(SQL_PATH, "w") as f:
        f.write("\n".join(lines))


def main():
    with open(RAW_PATH, newline="") as f:
        reader = csv.DictReader(f)
        rows = list(reader)

    cleaned = clean_rows(rows)
    write_clean_csv(cleaned)
    write_sql(cleaned)

    print(f"Raw rows: {len(rows)}")
    print(f"Cleaned rows: {len(cleaned)}")
    print(f"Dropped (missing amount or duplicate): {len(rows) - len(cleaned)}")


if __name__ == "__main__":
    main()
