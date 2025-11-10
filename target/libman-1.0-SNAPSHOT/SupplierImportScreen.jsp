<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.libman.model.Manager" %>
<%@ page import="com.libman.model.Invoice" %>
<%@ page import="com.libman.dao.InvoiceDAO" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Kiểm tra đăng nhập
    Manager manager = (Manager) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    String errorMessage = null;
    List<Invoice> invoices = null;
    String supplierName = null;
    int supplierId = 0;
    
    try {
        // Lấy supplierId từ parameter
        String supplierIdStr = request.getParameter("supplierId");
        
        if (supplierIdStr == null || supplierIdStr.isEmpty()) {
            response.sendRedirect("SupplierStatisticsScreen.jsp");
            return;
        }
        
        supplierId = Integer.parseInt(supplierIdStr);
        
        // Lấy date range từ session
        Date startDate = (Date) session.getAttribute("startDate");
        Date endDate = (Date) session.getAttribute("endDate");
        
        if (startDate == null || endDate == null) {
            response.sendRedirect("SupplierStatisticsScreen.jsp");
            return;
        }
        
        // Gọi InvoiceDAO để lấy danh sách hóa đơn
        InvoiceDAO invoiceDAO = new InvoiceDAO();
        invoices = invoiceDAO.getSupplierImportDocument(supplierId, startDate, endDate);
        
        if (!invoices.isEmpty()) {
            supplierName = invoices.get(0).getSupplier().getName();
        }
        
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        
    } catch (NumberFormatException e) {
        response.sendRedirect("SupplierStatisticsScreen.jsp");
        return;
    } catch (Exception e) {
        e.printStackTrace();
        errorMessage = "Có lỗi xảy ra: " + e.getMessage();
    }
    
    DecimalFormat df = new DecimalFormat("#,###");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết nhập hàng - Nhà cung cấp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 LibMan - Quản lý</h1>
            <p>Chi tiết nhập hàng từ nhà cung cấp</p>
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
                <a href="SupplierStatisticsScreen.jsp">Thống kê nhà cung cấp</a>
                <span>›</span>
                <span>Chi tiết nhập hàng</span>
            </div>
            
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <h2>Chi tiết nhập hàng - <%= supplierName != null ? supplierName : "" %></h2>
                <a href="SupplierStatisticsScreen.jsp" 
                   class="btn btn-secondary">
                    ← Quay lại
                </a>
            </div>
            
            <% if (errorMessage != null) { %>
                <div class="message error">
                    <%= errorMessage %>
                </div>
            <% } %>
            
            <% if (invoices != null && !invoices.isEmpty()) { %>
                <div class="card">
                    <h3>Danh sách hóa đơn nhập hàng</h3>
                    <p style="color: #666; margin-bottom: 20px;">
                        Từ ngày <strong><%= sdf.format(request.getAttribute("startDate")) %></strong> 
                        đến ngày <strong><%= sdf.format(request.getAttribute("endDate")) %></strong>
                    </p>
                    
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Mã hóa đơn</th>
                                    <th>Ngày nhập</th>
                                    <th>Người tạo</th>
                                    <th>Người nhập</th>
                                    <th style="text-align: right;">Tổng giá trị</th>
                                    <th style="text-align: center;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                int index = 1;
                                for (Invoice invoice : invoices) { 
                                %>
                                    <tr onclick="viewInvoiceDetail(<%= invoice.getId() %>)" 
                                        style="cursor: pointer;">
                                        <td><%= index++ %></td>
                                        <td><strong>#<%= invoice.getId() %></strong></td>
                                        <td>
                                            <%= sdf.format(invoice.getCreateDate()) %>
                                        </td>
                                        <td><%= invoice.getManagerName() %></td>
                                        <td><%= invoice.getStaffName() %></td>
                                        <td style="text-align: right;">
                                            <%= df.format(invoice.getTotalPrice()) %> 
                                            <span style="color: #666;">VNĐ</span>
                                        </td>
                                        <td style="text-align: center;">
                                            <a href="DetailImportScreen.jsp?invoiceId=<%= invoice.getId() %>" 
                                               class="btn btn-link">
                                                Xem chi tiết →
                                            </a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                            <tfoot style="background: #f8f9fa; font-weight: bold;">
                                <tr>
                                    <td colspan="5" style="text-align: right;">Tổng cộng:</td>
                                    <td style="text-align: right;">
                                        <% 
                                        int totalSum = 0;
                                        for (Invoice inv : invoices) {
                                            totalSum += inv.getTotalPrice();
                                        }
                                        %>
                                        <%= df.format(totalSum) %> 
                                        <span style="color: #666;">VNĐ</span>
                                    </td>
                                    <td></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            <% } else { %>
                <div class="empty-state">
                    <h3>Không có dữ liệu</h3>
                    <p>Không tìm thấy hóa đơn nhập hàng nào từ nhà cung cấp này trong khoảng thời gian đã chọn.</p>
                </div>
            <% } %>
        </div>
    </div>
    
    <script>
        function viewInvoiceDetail(invoiceId) {
            window.location.href = 'DetailImportScreen.jsp?invoiceId=' + invoiceId;
        }
    </script>
</body>
</html>





