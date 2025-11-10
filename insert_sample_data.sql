-- ================================================================
-- INSERT SAMPLE DATA FOR LIBMAN SYSTEM
-- ================================================================

USE libman;

-- ================================================================
-- 1. INSERT MEMBERS (Người dùng)
-- ================================================================

INSERT INTO tblMember (username, password, name, gender, email, phone_number, birth_of_date, address) VALUES
-- Bạn đọc
('reader1', 'password123', 'Nguyễn Văn An', 'Nam', 'nguyenvanan@email.com', '0123456789', '2000-01-15', '123 Đường Láng, Đống Đa, Hà Nội'),
('reader2', 'password123', 'Trần Thị Bình', 'Nữ', 'tranthib@email.com', '0123456790', '1999-05-20', '456 Giải Phóng, Hai Bà Trưng, Hà Nội'),
('reader3', 'password123', 'Lê Hoàng Cường', 'Nam', 'lehoangcuong@email.com', '0123456791', '2001-03-10', '789 Nguyễn Trãi, Thanh Xuân, Hà Nội'),
('reader4', 'password123', 'Phạm Thị Dung', 'Nữ', 'phamthidung@email.com', '0123456792', '2000-08-25', '321 Cầu Giấy, Cầu Giấy, Hà Nội'),
('reader5', 'password123', 'Hoàng Văn Em', 'Nam', 'hoangvanem@email.com', '0123456793', '1998-12-30', '654 Xã Đàn, Đống Đa, Hà Nội'),

-- Nhân viên và Quản lý
('staff1', 'password123', 'Vũ Thị Phương', 'Nữ', 'vuthiphuong@email.com', '0987654321', '1990-06-15', '111 Láng Hạ, Đống Đa, Hà Nội'),
('manager1', 'password123', 'Trần Văn Kiên', 'Nam', 'tranvankien@email.com', '0987654322', '1985-05-20', '222 Nguyễn Chí Thanh, Đống Đa, Hà Nội'),
('manager2', 'password123', 'Nguyễn Thị Lan', 'Nữ', 'nguyenthilan@email.com', '0987654323', '1988-09-10', '333 Trần Duy Hưng, Cầu Giấy, Hà Nội');

-- ================================================================
-- 2. INSERT READERS (Bạn đọc)
-- ================================================================

INSERT INTO tblReader (rating, tblMemberid) VALUES
(5, 1),  -- reader1
(4, 2),  -- reader2
(5, 3),  -- reader3
(3, 4),  -- reader4
(4, 5);  -- reader5

-- ================================================================
-- 3. INSERT STAFF & MANAGERS (Nhân viên và Quản lý)
-- ================================================================

INSERT INTO tblStaff (position, tblMemberid) VALUES
('Nhân viên thư viện', 6),  -- staff1
('Quản lý thư viện', 7),     -- manager1
('Phó giám đốc', 8);         -- manager2

INSERT INTO tblLibraryStaff (status, tblMemberid) VALUES
('Đang làm việc', 6);  -- staff1

INSERT INTO tblManager (role, tblMemberid) VALUES
('Quản lý thư viện', 7),   -- manager1
('Phó giám đốc', 8);        -- manager2

-- ================================================================
-- 4. INSERT SUPPLIERS (Nhà cung cấp)
-- ================================================================

INSERT INTO tblSupplier (name, phone_number, email, address) VALUES
('Nhà xuất bản Kim Đồng', '024-3943-4730', 'kimdong@nxb.com', '55 Quang Trung, Hà Nội'),
('Nhà xuất bản Trẻ', '028-3930-7551', 'nxbtre@nxbtre.com', '161B Lý Chính Thắng, TP.HCM'),
('Công ty Sách Fahasa', '024-3562-6341', 'fahasa@fahasa.com', '60-62 Lê Lợi, Hà Nội'),
('Nhà xuất bản Giáo dục', '024-3822-5340', 'nxbgd@nxbgd.com', '81 Trần Hưng Đạo, Hà Nội'),
('Công ty Alpha Books', '028-3820-8544', 'alphabooks@alpha.com', '134 Điện Biên Phủ, TP.HCM'),
('Nhà xuất bản Lao Động', '024-3852-1281', 'nxbld@nxbld.com', '175 Giảng Võ, Hà Nội');

-- ================================================================
-- 5. INSERT DOCUMENTS (Tài liệu)
-- ================================================================

INSERT INTO tblDocument (name, author, status, note) VALUES
-- Sách lập trình
('Lập trình Java cơ bản', 'Phạm Văn Ất', 'Có sẵn', 'Sách dành cho người mới bắt đầu'),
('Lập trình Java nâng cao', 'Nguyễn Văn B', 'Có sẵn', 'Sách chuyên sâu về Java'),
('Cấu trúc dữ liệu và giải thuật', 'Nguyễn Đức Nghĩa', 'Có sẵn', 'Tái bản lần 3'),
('Lập trình Python từ cơ bản đến nâng cao', 'Trần Minh C', 'Có sẵn', 'Kèm CD bài tập'),
('JavaScript The Good Parts', 'Douglas Crockford', 'Có sẵn', 'Bản tiếng Anh'),

-- Sách cơ sở dữ liệu
('Cơ sở dữ liệu nâng cao', 'Lê Thị Mai', 'Có sẵn', 'SQL Server và Oracle'),
('MongoDB cho người mới bắt đầu', 'Hoàng Văn D', 'Có sẵn', 'NoSQL Database'),
('Thiết kế cơ sở dữ liệu', 'Vũ Thị E', 'Có sẵn', 'Kèm ví dụ thực tế'),

-- Sách mạng và bảo mật
('Mạng máy tính', 'Phan Văn F', 'Có sẵn', 'Tái bản 2023'),
('An toàn thông tin mạng', 'Đỗ Thị G', 'Có sẵn', 'Có CD kèm theo'),
('Ethical Hacking cơ bản', 'Trương Văn H', 'Có sẵn', NULL),

-- Sách AI và Machine Learning
('Trí tuệ nhân tạo', 'Nguyễn Văn I', 'Có sẵn', 'AI fundamentals'),
('Machine Learning cơ bản', 'Lê Văn J', 'Có sẵn', 'Với Python và TensorFlow'),
('Deep Learning cho người mới', 'Phạm Thị K', 'Có sẵn', 'Neural Networks'),

-- Sách phát triển web
('HTML5 và CSS3 toàn tập', 'Trần Văn L', 'Có sẵn', 'Web Development'),
('ReactJS từ cơ bản đến nâng cao', 'Nguyễn Thị M', 'Có sẵn', 'Frontend framework'),
('Node.js Backend Development', 'Hoàng Văn N', 'Có sẵn', 'Server-side JavaScript'),

-- Sách thiết kế phần mềm
('Design Patterns', 'Gang of Four', 'Có sẵn', 'Bản tiếng Việt'),
('Clean Code', 'Robert C. Martin', 'Có sẵn', 'Nghệ thuật viết code sạch'),
('Refactoring', 'Martin Fowler', 'Có sẵn', 'Cải tiến code hiện có'),

-- Sách quản lý dự án
('Scrum và Agile', 'Vũ Văn O', 'Có sẵn', 'Quản lý dự án linh hoạt'),
('DevOps Handbook', 'Gene Kim', 'Có sẵn', 'DevOps practices'),

-- Sách văn học (đa dạng thể loại)
('Đắc Nhân Tâm', 'Dale Carnegie', 'Có sẵn', 'Sách bán chạy nhất'),
('Nhà Giả Kim', 'Paulo Coelho', 'Có sẵn', 'Tiểu thuyết triết lý'),
('Sapiens: Lược sử loài người', 'Yuval Noah Harari', 'Có sẵn', 'Lịch sử nhân loại'),
('Tư duy nhanh và chậm', 'Daniel Kahneman', 'Có sẵn', 'Tâm lý học'),

-- Sách kinh tế
('Kinh tế học vi mô', 'Gregory Mankiw', 'Có sẵn', 'Giáo trình đại học'),
('The Lean Startup', 'Eric Ries', 'Có sẵn', 'Khởi nghiệp tinh gọn'),
('Rich Dad Poor Dad', 'Robert Kiyosaki', 'Có sẵn', 'Tư duy làm giàu');

-- ================================================================
-- 6. INSERT INVOICES (Hóa đơn nhập hàng)
-- ================================================================

INSERT INTO tblInvoice (total_price, create_date, tblManagerid, tblLibraryStaffid) VALUES
-- Tháng 1/2024
(15000000, '2024-01-05', 7, 6),  -- Invoice 1
(8500000, '2024-01-15', 7, 6),   -- Invoice 2
(12000000, '2024-01-25', 8, 6),  -- Invoice 3

-- Tháng 2/2024
(20000000, '2024-02-08', 7, 6),  -- Invoice 4
(9500000, '2024-02-18', 8, 6),   -- Invoice 5
(14000000, '2024-02-28', 7, 6),  -- Invoice 6

-- Tháng 3/2024
(18000000, '2024-03-10', 7, 6),  -- Invoice 7
(11000000, '2024-03-20', 8, 6),  -- Invoice 8

-- Tháng 4/2024
(25000000, '2024-04-05', 7, 6),  -- Invoice 9
(13500000, '2024-04-15', 7, 6),  -- Invoice 10

-- Tháng 5/2024
(16000000, '2024-05-10', 8, 6),  -- Invoice 11
(19000000, '2024-05-20', 7, 6),  -- Invoice 12

-- Tháng 6/2024 (gần đây)
(22000000, '2024-06-05', 7, 6),  -- Invoice 13
(15500000, '2024-06-15', 8, 6),  -- Invoice 14
(21000000, '2024-06-25', 7, 6);  -- Invoice 15

-- ================================================================
-- 7. INSERT IMPORT DOCUMENTS (Chi tiết nhập tài liệu)
-- ================================================================

-- Invoice 1 (Nhà xuất bản Kim Đồng)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(50, 150000, 1, 1, 1),   -- Lập trình Java cơ bản
(30, 200000, 1, 3, 1),   -- Cấu trúc dữ liệu
(40, 180000, 1, 9, 1);   -- Mạng máy tính

-- Invoice 2 (Nhà xuất bản Trẻ)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(35, 170000, 2, 2, 2),   -- Java nâng cao
(25, 160000, 2, 4, 2);   -- Python

-- Invoice 3 (Fahasa)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(40, 190000, 3, 5, 3),   -- JavaScript
(30, 180000, 3, 6, 3),   -- CSDL nâng cao
(20, 210000, 3, 12, 3);  -- Machine Learning

-- Invoice 4 (Nhà xuất bản Giáo dục)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(60, 150000, 4, 15, 4),  -- HTML5 CSS3
(45, 200000, 4, 17, 4),  -- Design Patterns
(30, 220000, 4, 18, 4);  -- Clean Code

-- Invoice 5 (Alpha Books)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(25, 180000, 5, 7, 5),   -- MongoDB
(20, 190000, 5, 8, 5);   -- Thiết kế CSDL

-- Invoice 6 (Nhà xuất bản Kim Đồng)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(40, 200000, 6, 10, 1),  -- An toàn thông tin
(35, 180000, 6, 11, 1);  -- Ethical Hacking

-- Invoice 7 (Nhà xuất bản Trẻ)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(50, 170000, 7, 13, 2),  -- Deep Learning
(40, 190000, 7, 14, 2);  -- Trí tuệ nhân tạo

-- Invoice 8 (Fahasa)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(30, 210000, 8, 16, 3),  -- ReactJS
(25, 200000, 8, 19, 3);  -- Refactoring

-- Invoice 9 (Nhà xuất bản Lao Động)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(60, 180000, 9, 22, 6),  -- Đắc Nhân Tâm
(50, 200000, 9, 23, 6),  -- Nhà Giả Kim
(45, 220000, 9, 24, 6);  -- Sapiens

-- Invoice 10 (Alpha Books)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(35, 190000, 10, 25, 5), -- Tư duy nhanh và chậm
(30, 195000, 10, 20, 5); -- Scrum và Agile

-- Invoice 11 (Nhà xuất bản Giáo dục)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(40, 200000, 11, 26, 4), -- Kinh tế học vi mô
(40, 200000, 11, 27, 4); -- The Lean Startup

-- Invoice 12 (Nhà xuất bản Kim Đồng)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(55, 180000, 12, 1, 1),  -- Lập trình Java cơ bản (tái nhập)
(40, 190000, 12, 9, 1);  -- Mạng máy tính (tái nhập)

-- Invoice 13 (Nhà xuất bản Trẻ)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(50, 200000, 13, 2, 2),  -- Java nâng cao (tái nhập)
(45, 210000, 13, 4, 2);  -- Python (tái nhập)

-- Invoice 14 (Fahasa)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(40, 195000, 14, 15, 3), -- HTML5 CSS3 (tái nhập)
(35, 185000, 14, 16, 3); -- ReactJS (tái nhập)

-- Invoice 15 (Nhà xuất bản Lao Động)
INSERT INTO tblImportDocument (quantity, price, tblInvoiceid, tblDocumentid, tblSupplierid) VALUES
(70, 180000, 15, 22, 6), -- Đắc Nhân Tâm (tái nhập)
(50, 200000, 15, 23, 6), -- Nhà Giả Kim (tái nhập)
(40, 220000, 15, 28, 6); -- Rich Dad Poor Dad

-- ================================================================
-- 8. INSERT LIBRARY CARDS (Thẻ bạn đọc)
-- ================================================================

INSERT INTO tblLibraryCard (expiration_date, note, image, tblReaderid) VALUES
('2025-01-15', 'Thẻ đăng ký lần đầu', 'card_reader1.jpg', 1),
('2025-05-20', 'Gia hạn thẻ', 'card_reader2.jpg', 2),
('2025-03-10', NULL, 'card_reader3.jpg', 3);

-- ================================================================
-- 9. INSERT BORROW SLIPS (Phiếu mượn sách)
-- ================================================================

INSERT INTO tblBorrowSlip (note, borrow_date, tblBorrowSlipId, tblReaderid) VALUES
('Mượn để học tập', '2024-06-01', NULL, 1),
('Mượn làm đồ án', '2024-06-05', NULL, 2),
('Mượn tham khảo', '2024-06-10', NULL, 3),
(NULL, '2024-06-15', NULL, 1),
('Mượn nghiên cứu', '2024-06-20', NULL, 4);

-- ================================================================
-- 10. INSERT BORROW SLIP DETAILS (Chi tiết phiếu mượn)
-- ================================================================

INSERT INTO tblBorrowSlipDetail (condition_borrow, tblBorrowSlipid, tblDocumentid) VALUES
('Tốt', 1, 1),
('Tốt', 1, 3),
('Tốt', 2, 4),
('Tốt', 2, 5),
('Khá', 3, 12),
('Tốt', 3, 13),
('Tốt', 4, 22),
('Tốt', 4, 23),
('Tốt', 5, 6),
('Tốt', 5, 7);

-- ================================================================
-- 11. INSERT RETURN SLIPS (Phiếu trả sách)
-- ================================================================

INSERT INTO tblReturnSlip (return_date, note, tblReaderid) VALUES
('2024-06-08', 'Trả đúng hạn', 1),
('2024-06-12', 'Trả đúng hạn', 2),
('2024-06-17', NULL, 3);

-- ================================================================
-- 12. INSERT RETURN SLIP DETAILS (Chi tiết phiếu trả)
-- ================================================================

INSERT INTO tblReturnSlipDetail (condition_return, tblDocumentid, tblRetunSlipid) VALUES
('Tốt', 1, 1),
('Tốt', 3, 1),
('Tốt', 4, 2),
('Khá', 5, 2),
('Tốt', 12, 3),
('Tốt', 13, 3);

-- ================================================================
-- DONE! Data inserted successfully
-- ================================================================

SELECT 'Data inserted successfully!' as Status;

-- Kiểm tra số lượng records
SELECT 
    'tblMember' as TableName, COUNT(*) as RecordCount FROM tblMember
UNION ALL
SELECT 'tblReader', COUNT(*) FROM tblReader
UNION ALL
SELECT 'tblManager', COUNT(*) FROM tblManager
UNION ALL
SELECT 'tblSupplier', COUNT(*) FROM tblSupplier
UNION ALL
SELECT 'tblDocument', COUNT(*) FROM tblDocument
UNION ALL
SELECT 'tblInvoice', COUNT(*) FROM tblInvoice
UNION ALL
SELECT 'tblImportDocument', COUNT(*) FROM tblImportDocument
UNION ALL
SELECT 'tblLibraryCard', COUNT(*) FROM tblLibraryCard
UNION ALL
SELECT 'tblBorrowSlip', COUNT(*) FROM tblBorrowSlip
UNION ALL
SELECT 'tblReturnSlip', COUNT(*) FROM tblReturnSlip;






