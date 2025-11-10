<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.libman.model.Manager" %>
<%@ page import="com.libman.model.Invoice" %>
<%@ page import="com.libman.model.ImportDocument" %>
<%@ page import="com.libman.dao.InvoiceDAO" %>
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
    Invoice invoice = null;
    
    try {
        // Lấy invoiceId từ parameter
        String invoiceIdStr = request.getParameter("invoiceId");
        
        if (invoiceIdStr == null || invoiceIdStr.isEmpty()) {
            response.sendRedirect("SupplierStatisticsScreen.jsp");
            return;
        }
        
        int invoiceId = Integer.parseInt(invoiceIdStr);
        
        // Gọi InvoiceDAO để lấy thông tin hóa đơn
        InvoiceDAO invoiceDAO = new InvoiceDAO();
        invoice = invoiceDAO.getInvoiceInfo(invoiceId);
        
        if (invoice == null) {
            errorMessage = "Không tìm thấy hóa đơn!";
        }
        
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
    <title>Chi tiết hóa đơn nhập</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 LibMan - Quản lý</h1>
            <p>Chi tiết hóa đơn nhập hàng</p>
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
                <span>Chi tiết hóa đơn</span>
            </div>
            
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <h2>Chi tiết hóa đơn <%= invoice != null ? "#" + invoice.getId() : "" %></h2>
                <button onclick="window.history.back()" class="btn btn-secondary">
                    ← Quay lại
                </button>
            </div>
            
            <% if (errorMessage != null) { %>
                <div class="message error">
                    <%= errorMessage %>
                </div>
            <% } %>
            
            <% if (invoice != null) { %>
                <!-- Invoice Information Card -->
                <div class="card" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                    <h3 style="color: white;">Thông tin hóa đơn</h3>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px; margin-top: 20px;">
                        <div>
                            <strong>Mã hóa đơn:</strong> #<%= invoice.getId() %>
                        </div>
                        <div>
                            <strong>Ngày nhập:</strong> 
                            <%= sdf.format(invoice.getCreateDate()) %>
                        </div>
                        <div>
                            <strong>Người tạo (Quản lý):</strong> <%= invoice.getManagerName() %>
                        </div>
                        <div>
                            <strong>Người nhập (Nhân viên):</strong> <%= invoice.getStaffName() %>
                        </div>
                        <div>
                            <strong>Tổng giá trị:</strong> 
                            <%= df.format(invoice.getTotalPrice()) %> VNĐ
                        </div>
                    </div>
                </div>
                
                <!-- Import Documents Table -->
                <div class="card">
                    <h3>Danh sách tài liệu nhập</h3>
                    
                    <% if (invoice.getDocumentImports() != null && !invoice.getDocumentImports().isEmpty()) { %>
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Tên tài liệu</th>
                                        <th>Nhà cung cấp</th>
                                        <th style="text-align: center;">Số lượng</th>
                                        <th style="text-align: right;">Đơn giá</th>
                                        <th style="text-align: right;">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    int index = 1;
                                    for (ImportDocument importDoc : invoice.getDocumentImports()) { 
                                    %>
                                        <tr>
                                            <td><%= index++ %></td>
                                            <td><strong><%= importDoc.getDocumentName() %></strong></td>
                                            <td><%= importDoc.getSupplierName() %></td>
                                            <td style="text-align: center;">
                                                <span style="background: #667eea; color: white; padding: 5px 12px; 
                                                      border-radius: 20px; font-weight: bold;">
                                                    <%= importDoc.getQuantity() %>
                                                </span>
                                            </td>
                                            <td style="text-align: right;">
                                                <%= df.format(importDoc.getPrice()) %> VNĐ
                                            </td>
                                            <td style="text-align: right; font-weight: bold;">
                                                <%= df.format(importDoc.getQuantity() * importDoc.getPrice()) %> VNĐ
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                                <tfoot style="background: #f8f9fa;">
                                    <tr style="font-weight: bold; font-size: 1.1em;">
                                        <td colspan="5" style="text-align: right; padding: 20px;">
                                            Tổng cộng:
                                        </td>
                                        <td style="text-align: right; color: #667eea; padding: 20px;">
                                            <%= df.format(invoice.getTotalPrice()) %> VNĐ
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        
                        <!-- Summary Statistics -->
                        <div class="grid" style="margin-top: 30px;">
                            <div class="stat-card">
                                <h4>Tổng số loại tài liệu</h4>
                                <div class="stat-value"><%= invoice.getDocumentImports().size() %></div>
                                <p style="opacity: 0.9;">loại tài liệu</p>
                            </div>
                            
                            <div class="stat-card" style="background: linear-gradient(135deg, #28a745 0%, #20c997 100%);">
                                <h4>Tổng số lượng nhập</h4>
                                <div class="stat-value">
                                    <% 
                                    int totalQty = 0;
                                    for (ImportDocument importDoc : invoice.getDocumentImports()) {
                                        totalQty += importDoc.getQuantity();
                                    }
                                    %>
                                    <%= totalQty %>
                                </div>
                                <p style="opacity: 0.9;">sản phẩm</p>
                            </div>
                            
                            <div class="stat-card" style="background: linear-gradient(135deg, #ffc107 0%, #ff9800 100%);">
                                <h4>Tổng giá trị</h4>
                                <div class="stat-value">
                                    <%= df.format(invoice.getTotalPrice()) %>
                                </div>
                                <p style="opacity: 0.9;">VNĐ</p>
                            </div>
                        </div>
                    <% } else { %>
                        <div class="empty-state">
                            <h3>Không có dữ liệu</h3>
                            <p>Hóa đơn này chưa có tài liệu nhập nào.</p>
                        </div>
                    <% } %>
                </div>
                
                <!-- Action Buttons -->
                <div style="display: flex; gap: 15px; margin-top: 30px;">
                    <button onclick="window.print()" class="btn btn-primary">
                        🖨️ In hóa đơn
                    </button>
                    <button onclick="window.history.back()" class="btn btn-secondary">
                        ← Quay lại
                    </button>
                </div>
            <% } %>
        </div>
    </div>
    
    <style>
        @media print {
            .nav-bar, .btn, .breadcrumb {
                display: none !important;
            }
            
            body {
                background: white;
            }
            
            .container {
                box-shadow: none;
            }
        }
    </style>
</body>
</html>





