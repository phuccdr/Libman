<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Xóa session
    session.invalidate();
    
    // Chuyển về trang đăng nhập
    response.sendRedirect(request.getContextPath() + "/login.jsp");
%>

