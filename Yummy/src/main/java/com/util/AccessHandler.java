package com.util;

import java.sql.*;
import hitstd.group.tool.database.DBConfig;

public class AccessHandler {
    
	private Connection session = null;
	
	public void open() throws Exception {       
		DBConfig cfg = new DBConfig();
		Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
        String dbPath = cfg.FilePath();

        session = DriverManager.getConnection(
        		"jdbc:ucanaccess://"+dbPath+";"
        );
	}
	
	public void close() throws Exception {
		session.close();		
	}
	
	public boolean checkUser(String userId, String password) throws Exception {
		String sql = String.format("SELECT * FROM users WHERE userId='%s' AND deleteFlag <> 1", userId);
		ResultSet rs = this.query(sql);
		
		if (rs.next()) { // 查詢結果不為空
            String dbPassword = rs.getString("password"); // 取得資料庫密碼
            return password.equals(dbPassword); // 密碼比對
        } else {
            return false; // 查無此 userId
        }
		
	}
	
	public UserInformation getUserInformation(String userId) throws Exception {
		UserInformation info = null;
		
		String sql = String.format("SELECT * FROM users WHERE userId='%s' AND deleteFlag <> 1", userId);
		ResultSet rs = this.query(sql);
			
		if (rs.next()) {		
			//取得基本資訊
			info = new UserInformation();
			info.userId = userId;
			info.userName = rs.getString("userName");
			info.iconPath = rs.getString("iconPath");
			info.createDate = rs.getDate("createDate").toString();
			info.lastSeenDate = rs.getDate("lastSeenDate").toString();		
			info.postCount = rs.getInt("postCount");
			
			//查詢成就等級
			sql = String.format("SELECT * FROM achievement WHERE minCriteria <= %d ORDER BY minCriteria DESC", info.postCount);
			rs = this.query(sql);
			rs.next();
			info.level = rs.getInt("level");
			info.achievementDescription = rs.getString("description");
			info.rankIconPath = rs.getString("rankIconPath");	
		}
	
		return info;		
	}
	
	private ResultSet query(String sql) throws Exception {	
		Statement smt= session.createStatement();
		return  smt.executeQuery(sql);
	}
	

}
