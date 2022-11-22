package com.kh.forworks.off.vo;

import lombok.Data;

@Data
public class OffCntVo {
	private int totalOff;
	private double useOff;
	private double leftOff;
	
	public void setLeftOff() {
		this.leftOff = this.totalOff - this.useOff; 
	}
	
	public void addHalfOff(int half) {
		this.useOff = this.useOff + (double)half/2;
	}
}
