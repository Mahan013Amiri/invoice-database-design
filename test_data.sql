PRAGMA foreign_keys = ON;

-- خریدار و فروشنده
INSERT INTO Buyer (buyer_id, name, address, phone, mobile, description)
VALUES (1, 'آقای جوزی', 'فردیس چهارراه قریشی نبش دو راهی بنفشه', '09125173398', NULL, NULL);

INSERT INTO Seller (seller_id, company_name, registration_no, economic_code, visitor_name)
VALUES (1, 'آفتاب', '1', NULL, 'مجتبی طبیب چی');

-- دو کالا
INSERT INTO Product (product_id, name, unit) VALUES (1, 'مینی شکلات ۲تیپ', 'باکس');
INSERT INTO Product (product_id, name, unit) VALUES (2, 'پاستیل میوه ای ۴۰گرم', 'بسته');

-- تاریخچه قیمت: مینی شکلات دو قیمت دارد، پاستیل یکی
INSERT INTO PriceHistory (product_id, start_date, price) VALUES (1, '1391/07/01', 60000);
INSERT INTO PriceHistory (product_id, start_date, price) VALUES (1, '1391/08/01', 70000);
INSERT INTO PriceHistory (product_id, start_date, price) VALUES (2, '1391/07/01', 82800);

-- یک فاکتور در تاریخ ۱۳۹۱/۰۷/۱۰ با دو ردیف
INSERT INTO Invoice (invoice_no, invoice_date, invoice_discount, cash_bonus, previous_debt, buyer_id, seller_id)
VALUES (101, '1391/07/10', 0, 0, 0, 1, 1);

INSERT INTO InvoiceLine (invoice_no, product_id, quantity, amount, price, discount_amount, discount_percent)
VALUES (101, 1, 1, 1, 60000, 0, 0);
INSERT INTO InvoiceLine (invoice_no, product_id, quantity, amount, price, discount_amount, discount_percent)
VALUES (101, 2, 1, 1, 82800, 0, 0);
