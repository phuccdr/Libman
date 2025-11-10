<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.libman.model.Reader" %>
<%@ page import="com.libman.model.LibraryCard" %>
<%@ page import="com.libman.dao.LibraryCardDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%@ page import="java.nio.file.Paths" %>
<%
    // Kiểm tra đăng nhập
    Reader reader = (Reader) session.getAttribute("reader");
    if (reader == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    LibraryCardDAO libraryCardDAO = new LibraryCardDAO();
    String successMessage = null;
    String errorMessage = null;
    String warningMessage = null;
    
    // Kiểm tra thẻ đã tồn tại
    boolean hasValidCard = libraryCardDAO.hasValidCard(reader.getId());
    if (hasValidCard) {
        warningMessage = "Bạn đã có thẻ bạn đọc còn hiệu lực!";
    }
    
    // Xử lý đăng ký thẻ khi submit form (POST)
    if ("POST".equalsIgnoreCase(request.getMethod()) && !hasValidCard) {
        try {
            // Lấy dữ liệu form
            String note = request.getParameter("note");
            Part filePart = request.getPart("image");
            
            
            
            // Validate image
            if (filePart == null || filePart.getSize() == 0) {
                errorMessage = "Vui lòng upload ảnh thẻ!";
            } else {
                // Lưu file vào thư mục avatarlibrarycard
                String uploadDir = application.getRealPath("") + File.separator + "avatarlibrarycard";
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) {
                    uploadDirFile.mkdirs();
                }
                
                String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                String uniqueFileName = "card_" + reader.getId() + "_" + System.currentTimeMillis() + fileExtension;
                String filePath = uploadDir + File.separator + uniqueFileName;
                
                filePart.write(filePath);
                
                // Tạo đường dẫn tương đối để lưu vào database
                String relativePath = "avatarlibrarycard/" + uniqueFileName;
                
                // Tạo đối tượng LibraryCard
                LibraryCard libraryCard = new LibraryCard();
                libraryCard.setReaderId(reader.getId());
                libraryCard.setNote(note);
                libraryCard.setImage(relativePath);
                
                // Set thời hạn 1 năm
                LocalDate expirationDate = LocalDate.now().plusYears(1);
                libraryCard.setExpirationDate(Date.valueOf(expirationDate));
                
                // Gọi DAO để tạo thẻ
                boolean success = libraryCardDAO.createCard(libraryCard);
                
                if (success) {
                    successMessage = "Đăng ký thẻ bạn đọc thành công!";
                } else {
                    errorMessage = "Đăng ký thẻ bạn đọc thất bại. Vui lòng thử lại!";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMessage = "Có lỗi xảy ra: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký thẻ bạn đọc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 LibMan - Bạn đọc</h1>
            <p>Đăng ký thẻ bạn đọc</p>
        </div>
        
        <div class="nav-bar">
            <div class="nav-links">
                <a href="HomeScreen.jsp">Trang chủ</a>
                <a href="RegisterLibraryCardScreen.jsp">Đăng ký thẻ bạn đọc</a>
            </div>
            <div class="user-info">
                <span>Xin chào, <%= reader.getName() %></span>
                <a href="logout.jsp" class="btn btn-secondary">Đăng xuất</a>
            </div>
        </div>
        
        <div class="content">
            <div class="breadcrumb">
                <a href="HomeScreen.jsp">Trang chủ</a>
                <span>›</span>
                <span>Đăng ký thẻ bạn đọc</span>
            </div>
            
            <h2>Đăng ký thẻ bạn đọc</h2>
            
            <% if (successMessage != null) { %>
                <div class="message success">
                    <%= successMessage %>
                    <div style="margin-top: 15px;">
                        <a href="HomeScreen.jsp" class="btn btn-primary">
                            Quay về trang chủ
                        </a>
                    </div>
                </div>
            <% } %>
            
            <% if (errorMessage != null) { %>
                <div class="message error">
                    <%= errorMessage %>
                </div>
            <% } %>
            
            <% if (warningMessage != null) { %>
                <div class="message warning">
                    <%= warningMessage %>
                </div>
            <% } %>
            
            <% if (successMessage == null) { %>
                <div class="card">
                    <h3>Thông tin đăng ký</h3>
                    
                    <form action="RegisterLibraryCardScreen.jsp" 
                          method="post" enctype="multipart/form-data" id="registerForm">
                        
                        <div class="form-group">
                            <label>Thông tin bạn đọc</label>
                            <div style="background: #f8f9fa; padding: 15px; border-radius: 8px; margin-bottom: 15px;">
                                <p><strong>Họ và tên:</strong> <%= reader.getName() %></p>
                                <p><strong>Email:</strong> <%= reader.getEmail() != null ? reader.getEmail() : "Chưa cập nhật" %></p>
                                <p><strong>Số điện thoại:</strong> <%= reader.getPhoneNumber() != null ? reader.getPhoneNumber() : "Chưa cập nhật" %></p>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="image">Ảnh thẻ bạn đọc *</label>
                            <div class="file-upload">
                                <input type="file" id="image" name="image" accept="image/*" required 
                                       onchange="previewImage(event)">
                                <label for="image" class="file-upload-label">
                                    📤 Chọn ảnh để upload
                                </label>
                            </div>
                            <small style="color: #666; display: block; margin-top: 5px;">
                                * Chọn ảnh chân dung của bạn (định dạng: JPG, PNG, tối đa 10MB)
                            </small>
                        </div>
                        
                        <div id="imagePreview" style="display: none; margin-bottom: 20px;">
                            <label>Xem trước ảnh:</label>
                            <img id="previewImg" style="max-width: 300px; max-height: 300px; 
                                 border-radius: 8px; border: 2px solid #e0e0e0; display: block; margin-top: 10px;">
                        </div>
                        
                        <div class="form-group">
                            <label for="note">Ghi chú</label>
                            <textarea id="note" name="note" rows="4" 
                                      placeholder="Nhập ghi chú nếu có..."></textarea>
                        </div>
                        
                        <div class="form-group">
                            <label>Thông tin thẻ</label>
                            <div style="background: #f8f9fa; padding: 15px; border-radius: 8px;">
                                <p><strong>Thời hạn:</strong> 1 năm kể từ ngày đăng ký</p>
                                <p><strong>Trạng thái:</strong> Thẻ sẽ được kích hoạt sau khi đăng ký thành công</p>
                            </div>
                        </div>
                        
                        <div style="display: flex; gap: 15px; margin-top: 30px;">
                            <button type="submit" class="btn btn-primary" style="flex: 1;" 
                                    <%= hasValidCard ? "disabled" : "" %>>
                                Đăng ký thẻ
                            </button>
                            <a href="HomeScreen.jsp" 
                               class="btn btn-secondary" style="flex: 1; text-align: center;">
                                Hủy bỏ
                            </a>
                        </div>
                    </form>
                </div>
            <% } %>
        </div>
    </div>
    
    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('previewImg').src = e.target.result;
                    document.getElementById('imagePreview').style.display = 'block';
                    
                    // Update label text
                    const label = document.querySelector('.file-upload-label');
                    label.textContent = '✅ ' + file.name;
                    label.style.background = 'rgba(40, 167, 69, 0.1)';
                    label.style.borderColor = '#28a745';
                    label.style.color = '#28a745';
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>

