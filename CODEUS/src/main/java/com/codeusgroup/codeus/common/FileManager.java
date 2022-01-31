package com.codeusgroup.codeus.common;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service("fileManager")
public class FileManager {
	
    /**
     * 파일 업로드 메소든
     */
	public String saveFile(MultipartFile file, HttpServletRequest request, String path) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		// getServletContext() -> application에 접근
		// resources : webapp 밑의 resources
		
		String savePath = root + path;
		
		File folder = new File(savePath);
		if (!folder.exists()) {
			folder.mkdirs();
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String originFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "." + originFileName.substring(originFileName.indexOf(".") + 1);
		// 현재시간        + . + 확장자
		 
		String renamePath = folder + "/" + renameFileName;
		try {
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return renameFileName;
	}	
	
    /**
     * 파일 삭제 메소드
     */
	public void deleteFile(String fileName, HttpServletRequest request, String path) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + path;
		
		File f = new File(savePath + "/" + fileName);
		
		if (f.exists()) {
			f.delete();
		}
	}

}
