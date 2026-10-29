-- 1) تاریخچه قیمت مینی شکلات
SELECT * FROM PriceHistory WHERE product_id = 1;

-- 2) قیمت معتبر مینی شکلات در تاریخ ۱۳۹۱/۰۸/۱۵
SELECT price FROM PriceHistory
WHERE product_id = 1 AND start_date <= '1391/08/15'
ORDER BY start_date DESC
LIMIT 1;

-- 3) نمایش کامل فاکتور ۱۰۱ با اتصال شش جدول به هم
SELECT i.invoice_no, i.invoice_date, b.name AS buyer, s.company_name AS seller,
       p.name AS product, l.quantity, l.price, l.quantity * l.price AS row_total
FROM Invoice i
JOIN Buyer b       ON b.buyer_id   = i.buyer_id
JOIN Seller s      ON s.seller_id  = i.seller_id
JOIN InvoiceLine l ON l.invoice_no = i.invoice_no
JOIN Product p     ON p.product_id = l.product_id
WHERE i.invoice_no = 101;

-- 4) جمع کل فاکتور (محاسبه می‌شود، ذخیره نمی‌شود)
SELECT SUM(quantity * price - discount_amount) AS total
FROM InvoiceLine WHERE invoice_no = 101;
