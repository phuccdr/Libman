<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.libman.dao.MemberDAO" %>
<%@ page import="com.libman.model.Member" %>
<%@ page import="com.libman.model.Reader" %>
<%@ page import="com.libman.model.Manager" %>
<%
    String errorMessage = null;
    
    // Xử lý đăng nhập khi submit form (POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập đầy đủ thông tin!";
        } else {
            // Gọi DAO để xác thực
            MemberDAO memberDAO = new MemberDAO();
            Member member = memberDAO.authenticateMember(username, password);
            
            if (member != null) {
                // Kiểm tra loại người dùng
                String memberType = memberDAO.getMemberType(member.getId());
                
                // Lưu vào session
                session.setAttribute("member", member);
                session.setAttribute("memberType", memberType);
                
                if ("READER".equals(memberType)) {
                    Reader reader = memberDAO.getReaderByMemberId(member.getId());
                    session.setAttribute("reader", reader);
                    response.sendRedirect(request.getContextPath() + "/HomeScreen.jsp");
                    return;
                } else if ("MANAGER".equals(memberType)) {
                    Manager manager = memberDAO.getManagerByMemberId(member.getId());
                    session.setAttribute("manager", manager);
                    response.sendRedirect(request.getContextPath() + "/ManagerHomeScreen.jsp");
                    return;
                } else {
                    errorMessage = "Tài khoản không có quyền truy cập!";
                }
            } else {
                errorMessage = "Tên đăng nhập hoặc mật khẩu không đúng!";
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Hệ thống quản lý thư viện</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container login-container">
        <div class="header">
            <h1>📚 LibMan</h1>
            <p>Hệ thống quản lý thư viện</p>
        </div>
        
        <div class="login-form">
            <h2>Đăng nhập</h2>
            
            <% if (errorMessage != null) { %>
                <div class="message error">
                    <%= errorMessage %>
                </div>
            <% } %>
            
            <form action="login.jsp" method="post">
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" required 
                           placeholder="Nhập tên đăng nhập">
                </div>
                
                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input type="password" id="password" name="password" required 
                           placeholder="Nhập mật khẩu">
                </div>
                
                <button type="submit" class="btn btn-primary">Đăng nhập</button>
            </form>
            
        </div>
    </div>
</body>
</html>
