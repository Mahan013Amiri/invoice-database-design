PRAGMA foreign_keys = ON;

-- 1) خریدار
CREATE TABLE Buyer (
    buyer_id    INTEGER PRIMARY KEY,
    name        TEXT NOT NULL,
    address     TEXT,
    phone       TEXT,
    mobile      TEXT,
    description TEXT
);

-- 2) فروشنده
CREATE TABLE Seller (
    seller_id       INTEGER PRIMARY KEY,
    company_name    TEXT NOT NULL,
    registration_no TEXT,
    economic_code   TEXT,
    visitor_name    TEXT
);

-- 3) کالا (قیمت اینجا نیست؛ در PriceHistory نگهداری می‌شود)
CREATE TABLE Product (
    product_id INTEGER PRIMARY KEY,
    name       TEXT NOT NULL,
    unit       TEXT
);

-- 4) سابقه قیمت: هر کالا چند قیمت در طول زمان دارد
CREATE TABLE PriceHistory (
    product_id INTEGER NOT NULL,
    start_date TEXT NOT NULL,
    price      INTEGER NOT NULL,
    PRIMARY KEY (product_id, start_date),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- 5) فاکتور
CREATE TABLE Invoice (
    invoice_no       INTEGER PRIMARY KEY,
    invoice_date     TEXT NOT NULL,
    invoice_discount INTEGER DEFAULT 0,
    cash_bonus       INTEGER DEFAULT 0,
    previous_debt    INTEGER DEFAULT 0,
    buyer_id         INTEGER NOT NULL,
    seller_id        INTEGER NOT NULL,
    FOREIGN KEY (buyer_id)  REFERENCES Buyer(buyer_id),
    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id)
);

-- 6) ردیف فاکتور (جدول واسط بین فاکتور و کالا)
-- price = قیمت لحظه فروش، که با تغییر قیمت‌های بعدی عوض نمی‌شود
CREATE TABLE InvoiceLine (
    invoice_no       INTEGER NOT NULL,
    product_id       INTEGER NOT NULL,
    quantity         INTEGER NOT NULL,
    amount           INTEGER,
    price            INTEGER NOT NULL,
    discount_amount  INTEGER DEFAULT 0,
    discount_percent REAL DEFAULT 0,
    PRIMARY KEY (invoice_no, product_id),
    FOREIGN KEY (invoice_no) REFERENCES Invoice(invoice_no),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
