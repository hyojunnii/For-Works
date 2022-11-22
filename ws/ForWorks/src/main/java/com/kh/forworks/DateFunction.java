package com.kh.forworks;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateFunction {
	public static String getToday() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();        
		String day = sdf.format(now);
		
		return day;
	}
	
	public static String getThisMonth() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		Date now = new Date();        
		String day = sdf.format(now);
		
		return day;
	}
	
	public static String monthForm(String str) {
		String year = str.substring(0, 4);
		String month = str.substring(5, 7);
		String day = str.substring(8, 10);
		
		int yearNum = Integer.parseInt(year);
		int monthNum = Integer.parseInt(month);
		int dayNum = Integer.parseInt(day);
		
		if(dayNum != 1) {
			monthNum = monthNum + 1 ;
			if(monthNum == 13) {
				yearNum++;
				monthNum = 1;
			}
		}
		
		return yearNum + "-" + monthNum;
	}
}
