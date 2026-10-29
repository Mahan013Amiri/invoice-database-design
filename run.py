import os
import sqlite3

# مسیرها نسبت به پوشهٔ همین فایل ساخته می‌شوند
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DB_PATH = os.path.join(BASE_DIR, "invoice.db")
SCHEMA_PATH = os.path.join(BASE_DIR, "schema.sql")

# اگر دیتابیس قبلی هست پاکش کن تا هر بار از صفر ساخته شود
if os.path.exists(DB_PATH):
    os.remove(DB_PATH)

conn = sqlite3.connect(DB_PATH)

# اجرای کل فایل schema.sql
with open(SCHEMA_PATH, encoding="utf-8") as f:
    conn.executescript(f.read())

conn.commit()

# نمایش جدول‌های ساخته‌شده
print("Tables:")
for (name,) in conn.execute("SELECT name FROM sqlite_master WHERE type='table'"):
    print(" -", name)

# نمایش کلیدهای خارجی جدول InvoiceLine برای اطمینان
print("\nForeign keys of InvoiceLine:")
for fk in conn.execute("PRAGMA foreign_key_list(InvoiceLine)"):
    print(" -", fk[2], "(", fk[3], ")")

conn.close()
