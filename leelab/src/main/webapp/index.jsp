<%@page contentType="text/html"%>
<%@page pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%
    String keyword = request.getParameter("keyword");
    if(keyword == null) keyword = "";

    // ODBC 連線 Access
    Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
    String url = "jdbc:ucanaccess://C:\\Users\\User\\Documents\\GitHub\\Yummy\\leelab\\src\\main\\webapp\\LeeLab.accdb";
    Connection conn = DriverManager.getConnection(url);

    String sql = "SELECT * FROM Posts WHERE title LIKE ? OR restaurant LIKE ? OR cuisine LIKE ? ORDER BY created_time DESC";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, "%" + keyword + "%");
    ps.setString(2, "%" + keyword + "%");
    ps.setString(3, "%" + keyword + "%");

    ResultSet rs = ps.executeQuery();
%>

<html>
<head>
    <title>匿名美食留言 – 首頁</title>
</head>
<body>

<h1>匿名美食留言網站</h1>

<form method="get" action="index.jsp">
    <input type="text" name="keyword" placeholder="搜尋店名 / 料理種類 / 標題" value="<%=keyword%>">
    <button type="submit">搜尋</button>
</form>

<hr>

<h2>所有貼文</h2>

<%
while(rs.next()){
%>
    <div style="border:1px solid #ccc; padding:10px; margin:10px;">
        <h3>
            <a href="post.jsp?id=<%=rs.getInt("id")%>">
                <%=rs.getString("title")%>
            </a>
        </h3>

        <p>餐廳： <%=rs.getString("restaurant")%></p>
        <p>料理種類： <%=rs.getString("cuisine")%></p>
        <p><small>時間： <%=rs.getString("created_time")%></small></p>
    </div>
<%
}
conn.close();
%>

</body>
</html>


