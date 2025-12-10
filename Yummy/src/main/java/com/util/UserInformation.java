package com.util;

public class UserInformation {
	public UserInformation() { }
	public String userId;
	public String userName;
	public String createDate;
	public String lastSeenDate;
	public String modifiedDate;
	public String iconPath;
	public String achievementDescription = "";
	public String rankIconPath;
	public int level;
	public int  postCount;
	
	// Getter for java bean
	public String getUserId() { return userId; }
	public String getUserName() { return userName; }
	public String getCreateDate() { return createDate; }
	public String getLastSeenDate() { return lastSeenDate; }
	public String getModifiedDate() { return modifiedDate; }
	public String getIconPath() { return iconPath; }	
	public String getRankIconPath() { return rankIconPath; }	
	public String getAchievementDescription() { return achievementDescription; }
	public int getLevel() { return level; }
	public int getPostCount() { return postCount; }
}
