# 📚 LibMan - Hệ thống Quản lý Thư viện

Hệ thống quản lý thư viện được xây dựng bằng Java, JSP, Servlet theo mô hình MVC.

## 🔧 Yêu cầu hệ thống

- **JDK**: 11 trở lên
- **Apache Maven**: 3.6 trở lên
- **MySQL**: 5.7 trở lên hoặc MariaDB
- **Application Server**: Apache Tomcat 10.x, GlassFish 7.x, hoặc WildFly
- **IDE** (khuyến nghị): IntelliJ IDEA, Eclipse, hoặc NetBeans

## 📦 Cài đặt

### Bước 1: Clone hoặc Download project

```bash
# Nếu có git
git clone <repository-url>

# Hoặc download và giải nén
```

### Bước 2: Cài đặt MySQL/MariaDB

1. Tải và cài đặt MySQL từ: https://dev.mysql.com/downloads/mysql/
2. Khởi động MySQL service

### Bước 3: Tạo Database

Mở MySQL command line hoặc MySQL Workbench và chạy:

```bash
# Windows (Command Prompt)
mysql -u root -p < database.sql

# Hoặc trong MySQL shell
mysql> source D:/PTIT/Kỳ 7/Phân tích thiết kế hệ thống/source/libman/database.sql
```

Hoặc copy nội dung file `database.sql` và paste vào MySQL Workbench rồi Execute.

### Bước 4: Cấu hình kết nối Database

Mở file `src/main/java/com/libman/utils/DBConnection.java` và chỉnh sửa:

```java
private static final String URL = "jdbc:mysql://localhost:3306/libman?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
private static final String USERNAME = "root";
private static final String PASSWORD = "your_mysql_password"; 
```

### Bước 5: Build project

```bash
# Trong thư mục gốc của project
mvn clean install
```

## 🚀 Chạy ứng dụng

#### Với NetBeans:
1. Mở NetBeans IDE
2. File → Open Project → Chọn thư mục `libman`
3. Click chuột phải vào project → Run
4. NetBeans sẽ tự động deploy lên server được cấu hình

## 🌐 Truy cập ứng dụng

Sau khi chạy thành công, truy cập:

```
http://localhost:8080/libman
```

Hoặc nếu dùng IDE:
```
http://localhost:8080/libman-1.0-SNAPSHOT
```

## 👤 Tài khoản đăng nhập mẫu

## 📁 Cấu trúc Project

```
libman/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── libman/
│       │           ├── dao/             # Data Access Objects
│       │           ├── model/           # Entity classes (Model)
│       │           └── utils/           # Utilities (DBConnection)
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml             # Web config
│           ├── css/
│           │   └── style.css           # Stylesheet
│           ├── login.jsp               # Trang đăng nhập
│           ├── logout.jsp              # Đăng xuất
│           ├── HomeScreen.jsp          # Trang chủ Reader
│           ├── RegisterLibraryCardScreen.jsp  # Đăng ký thẻ
│           ├── ManagerHomeScreen.jsp   # Trang chủ Manager
│           ├── ChooseTypeStatisticsScreen.jsp # Chọn loại thống kê
│           ├── SupplierStatisticsScreen.jsp   # Thống kê NCC
│           ├── SupplierImportScreen.jsp       # Chi tiết nhập NCC
│           ├── DetailImportScreen.jsp  # Chi tiết hóa đơn
│           └── index.jsp               # Redirect to login
├── database.sql                         # Database script
├── pom.xml                              # Maven config
└── README.md                            # Hướng dẫn này
```


## 📝 Database Schema

Database `libman` bao gồm các bảng:

- `tblMember` - Thông tin người dùng
- `tblReader` - Bạn đọc (kế thừa Member)
- `tblStaff` - Nhân viên (kế thừa Member)
- `tblManager` - Quản lý (kế thừa Staff)
- `tblLibraryStaff` - Nhân viên thư viện (kế thừa Staff)
- `tblLibraryCard` - Thẻ bạn đọc
- `tblDocument` - Tài liệu
- `tblSupplier` - Nhà cung cấp
- `tblInvoice` - Hóa đơn nhập
- `tblImportDocument` - Chi tiết nhập tài liệu
- `tblBorrowSlip` - Phiếu mượn
- `tblBorrowSlipDetail` - Chi tiết phiếu mượn
- `tblReturnSlip` - Phiếu trả
- `tblReturnSlipDetail` - Chi tiết phiếu trả

## 🛠️ Công nghệ sử dụng

- **Backend**: JSP (Java Server Pages) - Logic xử lý trong JSP
- **Database**: MySQL
- **Build Tool**: Maven
- **Architecture**: JSP Model 2 (Modified)
- **Frontend**: HTML5, CSS3, JavaScript
- **Java**: Scriptlet trong JSP để xử lý logic
- **File Upload**: Multipart form data


## 📄 License

Project này được tạo cho mục đích học tập tại PTIT.

---

**Phát triển bởi**: Sinh viên PTIT  
**Môn học**: Phân tích thiết kế hệ thống  
**Năm học**: 2025-2026


