<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.libman.model.Manager" %>
<%
    // Kiểm tra đăng nhập
    Manager manager = (Manager) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Quản lý</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 LibMan - Quản lý</h1>
            <p>Hệ thống quản lý thư viện</p>
        </div>
        
        <div class="nav-bar">
            <div class="nav-links">
                <a href="ManagerHomeScreen.jsp">Trang chủ</a>
                <a href="ChooseTypeStatisticsScreen.jsp">Báo cáo thống kê</a>
            </div>
            <div class="user-info">
                <span>Xin chào, <%= manager.getName() %> (<%= manager.getRole() %>)</span>
                <a href="logout.jsp" class="btn btn-secondary">Đăng xuất</a>
            </div>
        </div>
        
        <div class="content">
            <h2>Chào mừng bạn đến với hệ thống quản lý thư viện!</h2>
            
            <div class="grid">
                <div class="card">
                    <h3>📊 Báo cáo thống kê</h3>
                    <p>Xem báo cáo thống kê về nhà cung cấp, tài liệu và hoạt động của thư viện.</p>
                    <a href="ChooseTypeStatisticsScreen.jsp" 
                       class="btn btn-primary" style="margin-top: 15px;">
                        Xem báo cáo
                    </a>
                </div>
                
                <div class="card">
                    <h3>📦 Quản lý nhập hàng</h3>
                    <p>Quản lý việc nhập tài liệu từ các nhà cung cấp.</p>
                    <button class="btn btn-primary" style="margin-top: 15px;" disabled>
                        Sắp ra mắt
                    </button>
                </div>
                
                <div class="card">
                    <h3>📚 Quản lý tài liệu</h3>
                    <p>Quản lý danh sách tài liệu trong thư viện.</p>
                    <button class="btn btn-primary" style="margin-top: 15px;" disabled>
                        Sắp ra mắt
                    </button>
                </div>
                
                <div class="card">
                    <h3>👥 Quản lý bạn đọc</h3>
                    <p>Quản lý thông tin bạn đọc và thẻ thư viện.</p>
                    <button class="btn btn-primary" style="margin-top: 15px;" disabled>
                        Sắp ra mắt
                    </button>
                </div>
                
                <div class="card">
                    <h3>🏢 Quản lý nhà cung cấp</h3>
                    <p>Quản lý thông tin các nhà cung cấp tài liệu.</p>
                    <button class="btn btn-primary" style="margin-top: 15px;" disabled>
                        Sắp ra mắt
                    </button>
                </div>
                
                <div class="card">
                    <h3>⚙️ Cài đặt</h3>
                    <p>Cấu hình hệ thống và thông tin cá nhân.</p>
                    <button class="btn btn-primary" style="margin-top: 15px;" disabled>
                        Sắp ra mắt
                    </button>
                </div>
            </div>
            
            <div class="card" style="margin-top: 30px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                <h3 style="color: white;">Thông tin quản lý</h3>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px; margin-top: 20px;">
                    <div>
                        <strong>Tên đăng nhập:</strong> <%= manager.getUsername() %>
                    </div>
                    <div>
                        <strong>Họ và tên:</strong> <%= manager.getName() %>
                    </div>
                    <div>
                        <strong>Email:</strong> <%= manager.getEmail() != null ? manager.getEmail() : "Chưa cập nhật" %>
                    </div>
                    <div>
                        <strong>Số điện thoại:</strong> <%= manager.getPhoneNumber() != null ? manager.getPhoneNumber() : "Chưa cập nhật" %>
                    </div>
                    <div>
                        <strong>Chức vụ:</strong> <%= manager.getPosition() %>
                    </div>
                    <div>
                        <strong>Vai trò:</strong> <%= manager.getRole() %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>





