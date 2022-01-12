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
	public String saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		// getServletContext() -> application에 접근
		// resources : webapp 밑의 resources
		String savePath = root + "/uploadFiles";
		
		File folder = new File(savePath);
		if (!folder.exists()) {
			folder.mkdirs();
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String originFileName = file.getOriginalFilename();
		String renameFileName 
			= sdf.format(new Date(System.currentTimeMillis())) + "." + originFileName.substring(originFileName.indexOf(".") + 1);
		//                                             현재시간        + . + 확장자
		 
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
	public void deleteFile(String fileName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/uploadFiles";
		
		File f = new File(savePath + "/" + fileName);
		
		if (f.exists()) {
			f.delete();
		}
	}
	
	/**
	 * 파일을 다운로드하는 메소드
	 * @param saveFilename		서버에 저장된 파일이름
	 * @param originalFilename	클라이언트가 업로드한 파일이름
	 * @param pathname			파일이 저장된 경로
	 * @param response			응답할 HttpServletResponse 객체
	 * @return					파일 다운로드 성공 여부
	 */
	public boolean doFileDownload(String saveFilename, String originalFilename, String pathname, HttpServletResponse response) {
		String fullpathname = pathname + File.separator + saveFilename;
		
        try {
    		if(originalFilename == null || originalFilename.equals(""))
    			originalFilename = saveFilename;
        	originalFilename = new String(originalFilename.getBytes("euc-kr"),"8859_1");
        } catch (UnsupportedEncodingException e) {
        }

	    try {
	        File file = new File(fullpathname);

	        if (file.exists()){
	            byte readByte[] = new byte[4096];

	            response.setContentType("application/octet-stream");
				response.setHeader(
						"Content-disposition",
						"attachment;filename=" + originalFilename);

	            BufferedInputStream  fin  = new BufferedInputStream(new FileInputStream(file));
	            //javax.servlet.ServletOutputStream outs =	response.getOutputStream();
	            OutputStream outs = response.getOutputStream();
	            
	   			int read;
	    		while ((read = fin.read(readByte, 0, 4096)) != -1)
	    				outs.write(readByte, 0, read);
	    		outs.flush();
	    		outs.close();
	            fin.close();
	            
	            return true;
	        }
	    } catch(Exception e) {
	    }
	    
	    return false;
	}
	
	/**
	 * 파일들을 zip 파일로 압축하여 다운로드하는 메소드
	 * @param sources		폴더명을 포함한 서버에 저장된 압축할 파일들(경로 포함) 
	 * @param originals		압축할 파일들이 압축될 때의 파일명
	 * @param zipFilename	다운로드할 때 클라이언트에 표시할 zip 파일명  
	 * @param response		응답할 HttpServletResponse 객체
	 * @return				파일 다운로드 성공 여부
	 */
	public boolean doZipFileDownload(String[] sources, String[] originals, String zipFilename, 
										HttpServletResponse request, HttpServletResponse response) {
		String pathname = System.getProperty("user.dir") + File.separator + "temp"; // user.dir : 현재 디렉토리
		String archiveFilename;
		
		// 파일들을 압축
		archiveFilename = fileCompression(sources, originals, pathname);
		if(archiveFilename==null) {
			return false;
		}
		
		// 파일 다운로드
        boolean b = doFileDownload(archiveFilename, zipFilename, pathname, response);
        
        // 압축한 zip 파일 삭제
        String fullpathname = pathname + File.separator + archiveFilename;
        doFileDelete(fullpathname);
        
		return b;
	}
	
	/**
	 * 파일을 삭제하는 메소드
	 * @param pathname	경로를 포함한 삭제할 파일이름
	 */
	public void doFileDelete(String pathname) {
		File file = new File(pathname);
        if (file.exists())
           file.delete();
	}
	
	/**
	 * 파일들을 압축하는 메소드
	 * @param sources		폴더명을 포함한 압축할 파일들
	 * @param originals		압축할 파일들이 압축될 때의 파일명
	 * @param pathname		압축 파일을 저장할 경로
	 * @return				압축된 파일명
	 */
	public String fileCompression(String[] sources, String[] originals, String pathname) {
		String archiveFilename = null;
		String fullpathname = null;
		
		final int MAX_SIZE = 2048;
		byte[] buf = new byte[MAX_SIZE];
		String s;
		File f;
		
        ZipOutputStream zos = null;
        FileInputStream fis = null;
        try {
        	f = new File(pathname);
        	if(! f.exists()) {
        		f.mkdirs();
        	}
        	
        	archiveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
        	archiveFilename += System.nanoTime() + ".zip";
        	fullpathname = pathname+File.separator+archiveFilename;
	
        	zos = new ZipOutputStream(new FileOutputStream(fullpathname));
 
        	int length;
            for(int idx=0; idx<sources.length; idx++) {
            	fis = new FileInputStream(sources[idx]);
            	
            	// 압축파일에 압축되는 파일명
            	// zos.putNextEntry(new ZipEntry(sources[idx]));
            	if(originals!=null && originals.length>=idx) {
            		s = originals[idx];
            	} else {
            		s = sources[idx].substring(sources[idx].lastIndexOf(File.separator));
            	}
            	if(s.indexOf(File.separator)==-1) s=File.separator+s;
            	zos.putNextEntry(new ZipEntry(s));
            	
            	length = 0;
                while ( ( length = fis.read(buf) ) > 0) {
                	zos.write(buf, 0, length);
                }
                zos.closeEntry();
                fis.close();
            }
            fis.close();
        } catch (IOException e) {
        } finally {
            try {
            	zos.closeEntry();
            	zos.close();
            } catch (IOException e) {
            }
        }
		
        f = new File(fullpathname);
        if(! f.exists())
        	return null;
        
		return archiveFilename;
	}
	
	/**
	 * 파일의 길이를 구하는 메소드
	 * @param pathname	길이를 구할 경로를 포함한 파일이름
	 * @return			파일의 길이
	 */
	public long getFilesize(String pathname) {
		long size=-1;
		
		File file = new File(pathname);
		if (! file.exists())
			return size;
		
		size=file.length();
		
		return size;
	}
	
	/**
	 * 파일의 타입을 구하는 메소드
	 * @param pathname	파일 타입을 구할 파일이름
	 * @return			파일 타입
	 */
	public String getFiletype(String pathname) {
		String type="";
		try {
			URL u = new URL("file:"+pathname);
		    URLConnection uc = u.openConnection();
		    type = uc.getContentType();
		} catch (Exception e) {
		}
		
	    return type;
	}

}
