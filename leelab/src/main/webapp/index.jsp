<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.example.model.Post" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>美食匿名留言板</title>
</head>
<body>

<h1>美食匿名網站</h1>

<!-- 搜尋列 -->
<form action="posts" method="get">
    關鍵字：<input type="text" name="q" value="${param.q}">
    類別：
    <select name="category">
        <option value="">全部</option>
        <option value="小吃">小吃</option>
        <option value="飲料">飲料</option>
        <option value="甜點">甜點</option>
    </select>
    <button type="submit">搜尋</button>
</form>

<hr>

<h2>所有貼文（依時間排序）</h2>

<%
    List<Post> posts = (List<Post>) request.getAttribute("posts");
    if (posts == null || posts.isEmpty()) {
%>
        <p>目前沒有貼文。</p>
<%
    } else {
        for (Post p : posts) {
%>

    <div style="border:1px solid #999; padding:10px; margin:10px 0;">
        <h3>
            <a href="post?id=<%= p.getId() %>">
                <%= p.getTitle() %>
            </a>
        </h3>
        <p>店名：<%= p.getShopName() %></p>
        <p>類別：<%= p.getCategory() %></p>
        <p>時間：<%= p.getCreatedAt() %></p>

        <%
            // 判斷是否登入（session 有 userId 就代表登入）
            Object userId = session.getAttribute("userId");
            if (userId != null) {
        %>
            <p>
                <a href="like?postId=<%=p.getId()%>">👍 按讚</a> |
                <a href="bookmark?postId=<%=p.getId()%>">★ 收藏</a> |
                <a href="post?id=<%=p.getId()%>#comment">留言</a>
            </p>
        <%
            } else {
        %>
            <p style="color:gray;">（登入後可按讚 / 收藏 / 留言）</p>
        <%
            }
        %>
    </div>

<%
        }
    }
%>

</body>
</html>

