-- Database: libman
CREATE DATABASE IF NOT EXISTS libman CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE libman;

-- Table: tblMember
CREATE TABLE IF NOT EXISTS tblMember (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    gender VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(255),
    birth_of_date DATE,
    address VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: tblReader
CREATE TABLE IF NOT EXISTS tblReader (
    rating INT NOT NULL DEFAULT 0,
    tblMemberid INT NOT NULL,
    PRIMARY KEY (tblMemberid),
    FOREIGN KEY (tblMemberid) REFERENCES tblMember(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: tblStaff
CREATE TABLE IF NOT EXISTS tblStaff (
    position VARCHAR(255),
    tblMemberid INT NOT NULL,
    PRIMARY KEY (tblMemberid),
    FOREIGN KEY (tblMemberid) REFERENCES tblMember(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: tblLibraryStaff
CREATE TABLE IF NOT EXISTS tblLibraryStaff (
    status VARCHAR(255),
    tblMemberid INT NOT NULL,
    PRIMARY KEY (tblMemberid),
    FOREIGN KEY (tblMemberid) REFERENCES tblStaff(tblMemberid) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: tblManager
CREATE TABLE IF NOT EXISTS tblManager (
    role VARCHAR(255),
    tblMemberid INT NOT NULL,
    PRIMARY KEY (tblMemberid),
    FOREIGN KEY (tblMemberid) REFERENCES tblStaff(tblMemberid) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: tblLibraryCard
CREATE TABLE IF NOT EXISTS tblLibraryCard (
    id INT PRIMARY KEY AUTO_INCREMENT,
    expiration_date DATE,
    note VARCHAR(255),
    image VARCHAR(255),
    tblReaderid INT NOT NULL,
    FOREIGN KEY (tblReaderid) REFERENCES tblReader(tblMemberid) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: tblDocument
CREATE TABLE IF NOT EXISTS tblDocument (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    status VARCHAR(255),
    note VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: tblSupplier
CREATE TABLE IF NOT EXISTS tblSupplier (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255),
    email VARCHAR(255),
    address VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: tblInvoice
CREATE TABLE IF NOT EXISTS tblInvoice (
    id INT PRIMARY KEY AUTO_INCREMENT,
    total_price INT,
    create_date DATE,
    tblManagerid INT NOT NULL,
    tblLibraryStaffid INT NOT NULL,
    FOREIGN KEY (tblManagerid) REFERENCES tblManager(tblMemberid),
    FOREIGN KEY (tblLibraryStaffid) REFERENCES tblLibraryStaff(tblMemberid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: tblImportDocument
CREATE TABLE IF NOT EXISTS tblImportDocument (
    id INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT NOT NULL,
    price INT NOT NULL,
    tblInvoiceid INT NOT NULL,
    tblDocumentid INT NOT NULL,
    tblSupplierid INT NOT NULL,
    FOREIGN KEY (tblInvoiceid) REFERENCES tblInvoice(id) ON DELETE CASCADE,
    FOREIGN KEY (tblDocumentid) REFERENCES tblDocument(id),
    FOREIGN KEY (tblSupplierid) REFERENCES tblSupplier(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: tblBorrowSlip
CREATE TABLE IF NOT EXISTS tblBorrowSlip (
    id INT PRIMARY KEY AUTO_INCREMENT,
    note VARCHAR(255),
    borrow_date DATE,
    tblBorrowSlipId INT,
    tblReaderid INT NOT NULL,
    FOREIGN KEY (tblBorrowSlipId) REFERENCES tblBorrowSlip(id),
    FOREIGN KEY (tblReaderid) REFERENCES tblReader(tblMemberid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: tblBorrowSlipDetail
CREATE TABLE IF NOT EXISTS tblBorrowSlipDetail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    condition_borrow VARCHAR(255),
    tblBorrowSlipid INT NOT NULL,
    tblDocumentid INT NOT NULL,
    FOREIGN KEY (tblBorrowSlipid) REFERENCES tblBorrowSlip(id) ON DELETE CASCADE,
    FOREIGN KEY (tblDocumentid) REFERENCES tblDocument(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: tblReturnSlip
CREATE TABLE IF NOT EXISTS tblReturnSlip (
    id INT PRIMARY KEY AUTO_INCREMENT,
    return_date DATE,
    note VARCHAR(255),
    tblReaderid INT NOT NULL,
    FOREIGN KEY (tblReaderid) REFERENCES tblReader(tblMemberid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: tblReturnSlipDetail
CREATE TABLE IF NOT EXISTS tblReturnSlipDetail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    condition_return VARCHAR(255),
    tblDocumentid INT NOT NULL,
    tblRetunSlipid INT NOT NULL,
    FOREIGN KEY (tblDocumentid) REFERENCES tblDocument(id),
    FOREIGN KEY (tblRetunSlipid) REFERENCES tblReturnSlip(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample data for testing
-- Insert Members
INSERT INTO tblMember (username, password, name, gender, email, phone_number, birth_of_date, address) VALUES
('reader1', 'password123', 'Nguyễn Văn A', 'Nam', 'nguyenvana@email.com', '0123456789', '2000-01-15', 'Hà Nội'),
('manager1', 'password123', 'Trần Thị B', 'Nữ', 'tranthib@email.com', '0987654321', '1985-05-20', 'Hồ Chí Minh');

-- Insert Reader
INSERT INTO tblReader (rating, tblMemberid) VALUES (5, 1);

-- Insert Staff and Manager
INSERT INTO tblStaff (position, tblMemberid) VALUES ('Quản lý', 2);
INSERT INTO tblManager (role, tblMemberid) VALUES ('Quản lý thư viện', 2);

-- Insert Suppliers
INSERT INTO tblSupplier (name, phone_number, email, address) VALUES
('Nhà xuất bản Kim Đồng', '024-3943-4730', 'kimdong@email.com', 'Hà Nội'),
('Nhà xuất bản Trẻ', '028-3930-7551', 'nxbtre@email.com', 'TP. Hồ Chí Minh'),
('Công ty Sách Alpha', '024-3826-8585', 'alpha@email.com', 'Hà Nội');

-- Insert Documents
INSERT INTO tblDocument (name, author, status, note) VALUES
('Lập trình Java cơ bản', 'Phạm Văn Ất', 'Có sẵn', 'Sách mới'),
('Cấu trúc dữ liệu và giải thuật', 'Nguyễn Đức Nghĩa', 'Có sẵn', 'Tái bản lần 3'),
('Cơ sở dữ liệu nâng cao', 'Lê Thị Mai', 'Có sẵn', NULL);




