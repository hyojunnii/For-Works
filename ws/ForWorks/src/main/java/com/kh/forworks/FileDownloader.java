package com.kh.forworks;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.kh.forworks.approv.service.ApprovService;
import com.kh.forworks.approv.vo.DocFileVo;

@RestController
public class FileDownloader {
	
	private final ApprovService service;
	
	@Autowired
	public FileDownloader(ApprovService service) {
		this.service = service;
	}
	
	@GetMapping("/download/{adocNo}")
	public void download(HttpServletRequest req,HttpServletResponse response,@PathVariable String adocNo) throws IOException {
        	
        	DocFileVo fileVo = service.selectDocFile(adocNo);
        	
        	if(fileVo!=null) {
        		
        	
        	String savePath = req.getServletContext().getRealPath("/resources/upload/doc/");
        	String path = savePath+fileVo.getDocfileEdit();
        	
        	byte[] fileByte = FileUtils.readFileToByteArray(new File(path));
        	

            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileVo.getDocfileOrigin(), "UTF-8")+"\";");
            response.setHeader("Content-Transfer-Encoding", "binary");

            response.getOutputStream().write(fileByte);
            response.getOutputStream().flush();
            response.getOutputStream().close();
        	}
        
    }

}
