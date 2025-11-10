<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.libman.model.Manager" %>
<%@ page import="com.libman.model.SupplierStatistics" %>
<%@ page import="com.libman.dao.SupplierStatisticsDAO" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    // Kiểm tra đăng nhập
    Manager manager = (Manager) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    String errorMessage = null;
    String message = null;
    List<SupplierStatistics> statisticsList = null;
    String startDateStr = request.getParameter("startDate");
    String endDateStr = request.getParameter("endDate");
    
    // Xử lý form submit (POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            // Validate dates
            if (startDateStr == null || startDateStr.isEmpty() || 
                endDateStr == null || endDateStr.isEmpty()) {
                errorMessage = "Vui lòng nhập đầy đủ ngày bắt đầu và ngày kết thúc!";
            } else {
                Date startDate = Date.valueOf(startDateStr);
                Date endDate = Date.valueOf(endDateStr);
                
                // Validate date range
                if (startDate.after(endDate)) {
                    errorMessage = "Ngày bắt đầu phải trước ngày kết thúc!";
                } else {
                    // Gọi DAO để generate thống kê
                    SupplierStatisticsDAO statisticsDAO = new SupplierStatisticsDAO();
                    statisticsList = statisticsDAO.generateStatistics(startDate, endDate);
                    
                    // Lưu vào session để dùng ở các trang khác
                    session.setAttribute("startDate", startDate);
                    session.setAttribute("endDate", endDate);
                    
                    if (statisticsList.isEmpty()) {
                        message = "Không có dữ liệu thống kê trong khoảng thời gian này!";
                    }
                }
            }
        } catch (IllegalArgumentException e) {
            errorMessage = "Định dạng ngày không hợp lệ!";
        } catch (Exception e) {
            e.printStackTrace();
            errorMessage = "Có lỗi xảy ra: " + e.getMessage();
        }
    }
    
    DecimalFormat df = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê nhà cung cấp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 LibMan - Quản lý</h1>
            <p>Thống kê nhà cung cấp theo số lượng nhập</p>
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
                <a href="ChooseTypeStatisticsScreen.jsp">Báo cáo thống kê</a>
                <span>›</span>
                <span>Thống kê nhà cung cấp</span>
            </div>
            
            <h2>Thống kê nhà cung cấp</h2>
            
            <% if (errorMessage != null) { %>
                <div class="message error">
                    <%= errorMessage %>
                </div>
            <% } %>
            
            <% if (message != null) { %>
                <div class="message warning">
                    <%= message %>
                </div>
            <% } %>
            
            <div class="card">
                <h3>Chọn khoảng thời gian thống kê</h3>
                
                <form action="SupplierStatisticsScreen.jsp" 
                      method="post" class="date-range-form">
                    
                    <div class="form-group">
                        <label for="startDate">Ngày bắt đầu</label>
                        <input type="date" id="startDate" name="startDate" 
                               value="<%= startDateStr != null ? startDateStr : "" %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="endDate">Ngày kết thúc</label>
                        <input type="date" id="endDate" name="endDate" 
                               value="<%= endDateStr != null ? endDateStr : "" %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>&nbsp;</label>
                        <button type="submit" class="btn btn-primary">
                            Thống kê
                        </button>
                    </div>
                </form>
            </div>
            
            <% if (statisticsList != null && !statisticsList.isEmpty()) { %>
                <div class="card">
                    <h3>Kết quả thống kê</h3>
                    <p style="color: #666; margin-bottom: 20px;">
                        Từ ngày <strong><%= startDateStr %></strong> đến ngày <strong><%= endDateStr %></strong>
                    </p>
                    
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Nhà cung cấp</th>
                                    <th style="text-align: right;">Số lượng nhập</th>
                                    <th style="text-align: right;">Tổng giá trị</th>
                                    <th style="text-align: center;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                int index = 1;
                                for (SupplierStatistics stat : statisticsList) { 
                                %>
                                    <tr onclick="viewSupplierImport(<%= stat.getSupplierId() %>)" 
                                        style="cursor: pointer;">
                                        <td><%= index++ %></td>
                                        <td><strong><%= stat.getSupplierName() %></strong></td>
                                        <td style="text-align: right;">
                                            <%= df.format(stat.getQuantity()) %> 
                                            <span style="color: #666;">sản phẩm</span>
                                        </td>
                                        <td style="text-align: right;">
                                            <%= df.format(stat.getTotalAmount()) %> 
                                            <span style="color: #666;">VNĐ</span>
                                        </td>
                                        <td style="text-align: center;">
                                            <a href="SupplierImportScreen.jsp?supplierId=<%= stat.getSupplierId() %>" 
                                               class="btn btn-link">
                                                Chi tiết →
                                            </a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
    
    <script>
        function viewSupplierImport(supplierId) {
            window.location.href = 'SupplierImportScreen.jsp?supplierId=' + supplierId;
        }
        
        // Set default dates if empty
        window.onload = function() {
            const startDate = document.getElementById('startDate');
            const endDate = document.getElementById('endDate');
            
            if (!startDate.value) {
                const today = new Date();
                const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
                startDate.value = firstDay.toISOString().split('T')[0];
            }
            
            if (!endDate.value) {
                const today = new Date();
                endDate.value = today.toISOString().split('T')[0];
            }
        };
    </script>
</body>
</html>





