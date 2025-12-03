<%@page contentType="text/html"%>
<%@page pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<html>
<head>
    <title>貼文詳細頁</title>
</head>
<body>

<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    String url = "jdbc:ucanaccess://C:\\Users\\User\\Documents\\GitHub\\Yummy\\leelab\\src\\main\\webapp\\LeeLab.accdb"; // 替換為你的 Access 資料庫路徑
    String user = ""; // 無需設定用戶名
    String password = ""; // 無需設定密碼
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
        conn = DriverManager.getConnection(url, user, password);

        String query = "SELECT * FROM posts WHERE post_id = ?";
        ps = conn.prepareStatement(query);
        ps.setInt(1, postId);

        rs = ps.executeQuery();

        if (rs.next()) {
%>
<h1><%= rs.getString("title") %></h1>
<p><%= rs.getString("content") %></p>
<p>餐廳: <%= rs.getString("restaurant_name") %></p>
<p>料理種類: <%= rs.getString("cuisine_type") %></p>
<p>創建時間: <%= rs.getTimestamp("create_time") %></p>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>

