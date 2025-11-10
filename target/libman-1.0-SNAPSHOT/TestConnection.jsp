<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.libman.utils.DBConnection" %>
<%@ page import="com.libman.dao.MemberDAO" %>
<%@ page import="com.libman.model.Member" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Test Database Connection</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        h1 {
            color: #667eea;
            border-bottom: 3px solid #667eea;
            padding-bottom: 10px;
        }
        .success {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            border-left: 4px solid #28a745;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            border-left: 4px solid #dc3545;
        }
        .info {
            background: #d1ecf1;
            color: #0c5460;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            border-left: 4px solid #17a2b8;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #667eea;
            color: white;
        }
        tr:hover {
            background: #f5f5f5;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }
        .btn:hover {
            background: #764ba2;
        }
        code {
            background: #f4f4f4;
            padding: 2px 6px;
            border-radius: 3px;
            font-family: 'Courier New', monospace;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔍 Kiểm tra kết nối Database</h1>
        
        <%
        Connection conn = null;
        boolean isConnected = false;
        String errorMessage = null;
        int totalMembers = 0;
        int totalReaders = 0;
        int totalManagers = 0;
        int totalSuppliers = 0;
        int totalDocuments = 0;
        
        try {
            // Test 1: Kiểm tra kết nối
            conn = DBConnection.getConnection();
            isConnected = (conn != null && !conn.isClosed());
            
            if (isConnected) {
                %>
                <div class="success">
                    <strong>✅ KẾT NỐI THÀNH CÔNG!</strong><br>
                    Database đã được kết nối thành công.
                </div>
                <%
                
                // Test 2: Đếm số lượng records
                Statement stmt = conn.createStatement();
                
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as total FROM tblMember");
                if (rs.next()) totalMembers = rs.getInt("total");
                
                rs = stmt.executeQuery("SELECT COUNT(*) as total FROM tblReader");
                if (rs.next()) totalReaders = rs.getInt("total");
                
                rs = stmt.executeQuery("SELECT COUNT(*) as total FROM tblManager");
                if (rs.next()) totalManagers = rs.getInt("total");
                
                rs = stmt.executeQuery("SELECT COUNT(*) as total FROM tblSupplier");
                if (rs.next()) totalSuppliers = rs.getInt("total");
                
                rs = stmt.executeQuery("SELECT COUNT(*) as total FROM tblDocument");
                if (rs.next()) totalDocuments = rs.getInt("total");
                
                %>
                
                <h2>📊 Thông tin Database</h2>
                <table>
                    <tr>
                        <th>Bảng</th>
                        <th>Số lượng records</th>
                        <th>Trạng thái</th>
                    </tr>
                    <tr>
                        <td><code>tblMember</code></td>
                        <td><strong><%= totalMembers %></strong></td>
                        <td><%= totalMembers >= 2 ? "✅" : "⚠️ Thiếu dữ liệu mẫu" %></td>
                    </tr>
                    <tr>
                        <td><code>tblReader</code></td>
                        <td><strong><%= totalReaders %></strong></td>
                        <td><%= totalReaders >= 1 ? "✅" : "⚠️ Thiếu dữ liệu mẫu" %></td>
                    </tr>
                    <tr>
                        <td><code>tblManager</code></td>
                        <td><strong><%= totalManagers %></strong></td>
                        <td><%= totalManagers >= 1 ? "✅" : "⚠️ Thiếu dữ liệu mẫu" %></td>
                    </tr>
                    <tr>
                        <td><code>tblSupplier</code></td>
                        <td><strong><%= totalSuppliers %></strong></td>
                        <td><%= totalSuppliers >= 3 ? "✅" : "⚠️ Thiếu dữ liệu mẫu" %></td>
                    </tr>
                    <tr>
                        <td><code>tblDocument</code></td>
                        <td><strong><%= totalDocuments %></strong></td>
                        <td><%= totalDocuments >= 3 ? "✅" : "⚠️ Thiếu dữ liệu mẫu" %></td>
                    </tr>
                </table>
                
                <h2>👥 Tài khoản mẫu</h2>
                <table>
                    <tr>
                        <th>Username</th>
                        <th>Tên</th>
                        <th>Loại</th>
                        <th>Email</th>
                    </tr>
                    <%
                    rs = stmt.executeQuery(
                        "SELECT m.*, " +
                        "CASE " +
                        "  WHEN r.tblMemberid IS NOT NULL THEN 'Bạn đọc' " +
                        "  WHEN mg.tblMemberid IS NOT NULL THEN 'Quản lý' " +
                        "  ELSE 'Chưa xác định' " +
                        "END as user_type " +
                        "FROM tblMember m " +
                        "LEFT JOIN tblReader r ON m.id = r.tblMemberid " +
                        "LEFT JOIN tblManager mg ON m.id = mg.tblMemberid"
                    );
                    
                    while (rs.next()) {
                    %>
                        <tr>
                            <td><code><%= rs.getString("username") %></code></td>
                            <td><%= rs.getString("name") %></td>
                            <td><strong><%= rs.getString("user_type") %></strong></td>
                            <td><%= rs.getString("email") != null ? rs.getString("email") : "N/A" %></td>
                        </tr>
                    <%
                    }
                    %>
                </table>
                
                <div class="info">
                    <strong>ℹ️ Thông tin kết nối:</strong><br>
                    • Database: <code>libman</code><br>
                    • Host: <code>localhost:3306</code><br>
                    • User: <code>root</code><br>
                    • Driver: <code>com.mysql.cj.jdbc.Driver</code>
                </div>
                
                <%
                // Test 3: Test DAO
                MemberDAO memberDAO = new MemberDAO();
                Member testMember = memberDAO.authenticateMember("reader1", "password123");
                
                if (testMember != null) {
                %>
                    <div class="success">
                        <strong>✅ TEST DAO THÀNH CÔNG!</strong><br>
                        Đăng nhập thử với username: <code>reader1</code> / password: <code>password123</code><br>
                        Kết quả: <strong><%= testMember.getName() %></strong>
                    </div>
                <%
                } else {
                %>
                    <div class="error">
                        <strong>❌ TEST DAO THẤT BẠI!</strong><br>
                        Không thể đăng nhập với tài khoản mẫu.
                    </div>
                <%
                }
                
                stmt.close();
            } else {
                %>
                <div class="error">
                    <strong>❌ KẾT NỐI THẤT BẠI!</strong><br>
                    Không thể kết nối đến database.
                </div>
                <%
            }
            
        } catch (Exception e) {
            errorMessage = e.getMessage();
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        
        if (errorMessage != null) {
        %>
            <div class="error">
                <strong>❌ LỖI:</strong><br>
                <%= errorMessage %>
                
                <h3>Giải pháp:</h3>
                <ol>
                    <li>Kiểm tra MySQL service đã chạy chưa</li>
                    <li>Kiểm tra database <code>libman</code> đã được tạo chưa</li>
                    <li>Kiểm tra username/password trong <code>DBConnection.java</code></li>
                    <li>Chạy lại file <code>database.sql</code></li>
                </ol>
            </div>
        <%
        }
        %>
        
        <h2>🔧 Hành động</h2>
        <a href="login.jsp" class="btn">🔐 Đi đến trang đăng nhập</a>
        <a href="TestConnection.jsp" class="btn" style="background: #28a745;">🔄 Kiểm tra lại</a>
        
        <div style="margin-top: 30px; padding: 15px; background: #f8f9fa; border-radius: 5px;">
            <strong>📝 Ghi chú:</strong><br>
            • Nếu tất cả đều ✅: Hệ thống đã sẵn sàng!<br>
            • Nếu có ⚠️: Cần import lại file <code>database.sql</code><br>
            • Nếu có ❌: Kiểm tra lại cấu hình database
        </div>
    </div>
</body>
</html>





