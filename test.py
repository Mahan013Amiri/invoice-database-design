import os
import sqlite3

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DB_PATH = os.path.join(BASE_DIR, "invoice.db")

conn = sqlite3.connect(DB_PATH)
conn.execute("PRAGMA foreign_keys = ON")

# وارد کردن داده‌های آزمایشی
with open(os.path.join(BASE_DIR, "test_data.sql"), encoding="utf-8") as f:
    conn.executescript(f.read())
conn.commit()

# اجرای هر پرس‌وجو و چاپ نتیجه
with open(os.path.join(BASE_DIR, "queries.sql"), encoding="utf-8") as f:
    text = f.read()

for block in text.split(";"):
    sql = block.strip()
    if not sql:
        continue
    title = sql.splitlines()[0]
    print(title)
    cur = conn.execute(sql)
    print("  ", [d[0] for d in cur.description])
    for row in cur.fetchall():
        print("  ", row)
    print()

# تست اینکه کلید خارجی کار می‌کند: فاکتور برای خریدار ناموجود باید خطا بدهد
try:
    conn.execute("INSERT INTO Invoice (invoice_no, invoice_date, buyer_id, seller_id) "
                 "VALUES (999, '1391/09/01', 12345, 1)")
    print("ERROR: should have failed")
except sqlite3.IntegrityError as e:
    print("کلید خارجی کار می‌کند، خطای مورد انتظار:", e)

conn.close()
