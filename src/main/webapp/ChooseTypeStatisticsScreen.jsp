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
    <title>Chọn loại thống kê</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 LibMan - Quản lý</h1>
            <p>Chọn loại báo cáo thống kê</p>
        </div>
        
        <div class="nav-bar">
            <div class="nav-links">
                <a href="ManagerHomeScreen.jsp">Trang chủ</a>
                <a href="ChooseTypeStatisticsScreen.jsp">Báo cáo thống kê</a>
            </div>
            <div class="user-info">
                <span>Xin chào, <%= manager.getName() %></span>
                <a href="logout.jsp" class="btn btn-secondary">Đăng xuất</a>
            </div>
        </div>
        
        <div class="content">
            <div class="breadcrumb">
                <a href="ManagerHomeScreen.jsp">Trang chủ</a>
                <span>›</span>
                <span>Báo cáo thống kê</span>
            </div>
            
            <h2>Chọn loại báo cáo thống kê</h2>
            
            <div class="grid">
                <div class="card" onclick="window.location.href='SupplierStatisticsScreen.jsp'" 
                     style="cursor: pointer;">
                    <h3>📊 Thống kê nhà cung cấp</h3>
                    <p>Xem báo cáo thống kê nhà cung cấp theo số lượng nhập hàng.</p>
                    <a href="SupplierStatisticsScreen.jsp" 
                       class="btn btn-primary" style="margin-top: 15px;">
                        Xem thống kê
                    </a>
                </div>
                
                <div class="card" style="opacity: 0.6;">
                    <h3>📚 Thống kê tài liệu</h3>
                    <p>Xem báo cáo thống kê về tài liệu được mượn nhiều nhất.</p>
                    <button class="btn btn-primary" style="margin-top: 15px;" disabled>
                        Sắp ra mắt
                    </button>
                </div>
                
                <div class="card" style="opacity: 0.6;">
                    <h3>👥 Thống kê bạn đọc</h3>
                    <p>Xem báo cáo thống kê về hoạt động của bạn đọc.</p>
                    <button class="btn btn-primary" style="margin-top: 15px;" disabled>
                        Sắp ra mắt
                    </button>
                </div>
                
                <div class="card" style="opacity: 0.6;">
                    <h3>💰 Thống kê doanh thu</h3>
                    <p>Xem báo cáo thống kê về chi phí nhập hàng và doanh thu.</p>
                    <button class="btn btn-primary" style="margin-top: 15px;" disabled>
                        Sắp ra mắt
                    </button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>





