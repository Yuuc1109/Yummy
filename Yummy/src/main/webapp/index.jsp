<%@ page import="com.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test page</title>
</head>
<body>

 <% //Get user information
    //Debug
    request.setAttribute("currentUserId", "test");
    
    String currentUserId = (String) request.getAttribute("currentUserId");   
    AccessHandler hdl = new AccessHandler();   
 	hdl.open();
 	UserInformation user = hdl.getUserInformation(currentUserId);
 	hdl.close();	    
    request.setAttribute("user", user);
 %>
 
	<!-- Display information -->
	<h1> User Information</h1>
	<p>User ID: ${user.userId}</p>
	<p>User Name: ${user.userName}</p>
	<p>Post Count: ${user.postCount}</p>
	<p>Created: ${user.createDate}</p>
	<p>LastSeen: ${user.lastSeenDate}</p>
    <p>AchievementDescription: ${user.achievementDescription}
       <img src='${user.rankIconPath}' width="20" height="20"/>
    </p>
    <p><img src='${user.iconPath}' width="200" height="200"/></p>
	
</body>
</html>