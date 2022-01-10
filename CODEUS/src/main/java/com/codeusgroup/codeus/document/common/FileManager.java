package com.codeusgroup.codeus.document.common;

import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;

// === #154. FileManager 클래스 생성하기 === 
@Component 
public class FileManager {

	// == 파일 업로드 하기 첫번째 방법 ==
	// path : 업로드 할 파일의 저장 경로 
	// 리턴값 : 서버에 저장된 새로운 파일명(예: 2020120809271535243254235235234.png)
	public String doFileUpload(byte[] bytes, String originalFilename, String path) throws Exception {
		
		String newFilename = null;
		
		if(bytes == null) {
			return null;
		}
		
		// 클라이언트가 업로드한 파일의 이름
		if("".equals(originalFilename)) {
			return null;
		}
		
		// 확장자 (예: 강아지  또는  강아지.png  또는   강.아.지.png)
		// 강아지.png   ==> originalFilename.lastIndexOf(".") ==> 3
		// 강.아.지.png ==> originalFilename.lastIndexOf(".") ==> 5
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf(".")); 
		if(fileExt == null || "".equals(fileExt)) {
			return null;
		}
		
		// 서버에 저장할 새로운 파일명을 만든다.
		// 서버에 저장할 새로운 파일명이 동일한 파일명이 되지 않고 고유한 파일명이 되도록 하기 위해
		// 현재의 년월일시분초에다가 현재 나노세컨즈nanoseconds 값을 결합하여 확장자를 붙여서 만든다.
		newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
		newFilename += System.nanoTime();
		newFilename += fileExt;
		// newFilename 은 예를 들면, 2020120809271535243254235235234.png 와 같이 된다.   
		
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성한다.
		File dir = new File(path);
		// 파라미터로 입력받은 문자열인 path(파일을 저장할 경로)를 실제 폴더로 만든다.
		// 자바에서는 File 클래스를 사용하여 폴더 또는 파일을 생성 및 관리를 하게 된다. 
		
		if(!dir.exists()) {
			// 만약에 파일을 저장할 경로인 폴더가 실제로 존재하지 않는다면 
			
			dir.mkdirs(); // 파일을 저장할 경로인 폴더를 생성한다.
		}
		
		String pathname = path + File.separator + newFilename;
		                      // File.separator 은 운영체제에서 사용하는 파일경로의 구분자 이다.
                              // 운영체제가 Windows 이라면 File.separator 은 "\" 이고,
                              // 운영체제가 UNIX 또는 Linux 이라면 File.separator 은 "/" 이다.
        // 해당경로에 \ 를 더하고 파일명을 더한 경로까지 나타내어준 파일명(문자열)을 만든다. 
		// pathname 은 예를 들면, C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files\2020120809271535243254235235234.png 이다.      
		
		FileOutputStream fos = new FileOutputStream(pathname);
		// FileOutputStream 는 해당 경로 파일명(pathname)에 실제로 데이터 내용(byte[] bytes)을 기록해주는 클래스 이다.
		// 이러한 일을 하는 FileOutputStream 객체 fos 를 생성한다.
		
		fos.write(bytes);
		// write(byte[] bytes) 메소드가 해당 경로 파일명(pathname)에 실제로 데이터 내용(byte[] bytes)을 기록해주는 일을 하는 것이다. 
		
		fos.close();
		// 생성된 FileOutputStream 객체 fos 가 더이상 사용되지 않도록 소멸 시킨다.
		
		return newFilename;
		// 파일을 업로드 한 이후에 
		// 업로드 되어진 파일명(현재의 년월일시분초에다가 현재 나노세컨즈nanoseconds 값을 결합하여 확장자를 붙여서 만든것)을 알아온다.
	}
	
	
	// == 파일 업로드 하기 두번째 방법 ==
	public String doFileUpload(InputStream is, String originalFilename, String path) throws Exception {
		String newFilename = null;

		// 클라이언트가 업로드한 파일의 이름
		if(originalFilename==null||originalFilename.equals(""))
			return null;
		
		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || fileExt.equals(""))
			return null;
		
		// 서버에 저장할 새로운 파일명을 만든다.
		newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
		newFilename += System.nanoTime();
		newFilename += fileExt;
		
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(path);
		if(!dir.exists())
			dir.mkdirs();
		
		String pathname = path + File.separator + newFilename;
		
		byte[] b=new byte[1024];
		int size=0;
		FileOutputStream fos = new FileOutputStream(pathname);
		
		while((size=is.read(b))!=-1) {
			fos.write(b, 0, size);
		}
		
		fos.close();
		is.close();
		
		return newFilename;
	}	
	
	
	// == 파일 다운로드 하기 ==
	// saveFilename : 서버에 저장된 파일명(현재의 년월일시분초에다가 현재 나노세컨즈nanoseconds 값을 결합하여 확장자를 붙여서 만든것)
	// originalFilename : 클라이언트가 업로드한 파일명(파일명이 영어로 되어진 경우도 있지만 한글로 되어진 경우가 있다는 것에 유의하자)
	// path : 서버에 저장된 경로
	public boolean doFileDownload(String saveFilename, String originalFilename, String path, HttpServletResponse response) {
		
		String pathname = path + File.separator + saveFilename;
        // File.separator 은 운영체제에서 사용하는 파일경로의 구분자 이다.
        // 운영체제가 Windows 이라면 File.separator 은 "\" 이고,
        // 운영체제가 UNIX 또는 Linux 이라면 File.separator 은 "/" 이다.
        // 해당경로에 \ 를 더하고 파일명을 더한 경로까지 나타내어준 파일명(문자열)을 만든다. 
        // pathname 은 예를 들면, C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files\2020120809271535243254235235234.png 이다. 
		
		try {
			if(originalFilename == null || "".equals(originalFilename)) {
				originalFilename = saveFilename;
			}
			
		//	originalFilename = new String(originalFilename.getBytes("EUC-KR"),"8859_1"); 
	    //	또는
			
	       	originalFilename = new String(originalFilename.getBytes("UTF-8"),"8859_1");
	       	// originalFilename.getBytes("UTF-8") 은 UTF-8 형태로 되어진 문자열 originalFilename 을 byte 형태로 변경한 후
	       	// byte 형태로 되어진 것을 표준인 ISO-Latin1(혹은 Latin1 또는 8859_1) 형태로 인코딩한 문자열로 만든다.
		} catch(UnsupportedEncodingException e) { }
		
		
		try {
			File file = new File(pathname);
			// 다운로드 할 파일명(pathname)을 가지고 File 객체를 생성한다.
		
			if(file.exists()) { // 실제로 다운로드할 해당 파일이 존재한다라면  
		
				byte[] readByte = new byte[4096];
				// 다운로드할 파일의 내용을 읽어오는 단위크기를 4096 byte로 하는 byte 배열 readByte 를 생성한다. 
				
				response.setContentType("application/octet-stream");
				// 다운로드할 파일의 종류에 따라 Content-Type 을 지정해주어야 한다.
	            // 이미지는 "image/jpeg" 같은 형식으로, 비디오는 "video/mpeg" 형식으로
	            // 기타 인코딩된 모든 파일들은 "application/octet-stream" 으로 지정해주어야 한다.
	            // 여기서는 모든 파일을 다운로드할 것이므로 기본값인 "application/octet-stream" 으로 지정해준다. 
				
				response.setHeader("Content-disposition",
				           		   "attachment; filename=" + originalFilename);
				// "Content-Disposition" 속성을 이용하여 해당 패킷이 어떤 형식의 데이터인지 알 수 있게 된다.
				// 다음으로 "attachment"로 설정하고 있다. 이는 첨부파일을 의미한다.
				
				BufferedInputStream bfin = new BufferedInputStream(new FileInputStream(file)); 
			    // 클라이언트가 다운로드 해야 할 파일(file)을 읽어들이기 위해 new FileInputStream(file) 을 생성함. 
				// 또한 빠르게 읽어들이기 위해서 필터스트림(보조스트림) BufferedInputStream bfin 을 장착함. 
				
				ServletOutputStream souts = response.getOutputStream();
				// ServletOutputStream 은 다운로드 되어질 파일을 클라이언트로 보내어주는 출력 스트림용 클래스이다. 
				
				int length = 0;
				
				while( (length = bfin.read(readByte, 0, 4096)) != -1  ) {
				/*
				    bfin.read(readByte, 0, 4096) 은 
				        다운로드 해주어야할 file에서 0(처음) 부터 4096 byte 만큼 읽어들인 후 
				    readByte 라는 변수에 읽어들인 내용을 저장시킨다.
				       그런데 다운로드 해주어야할 file에서 읽어들인 내용이 없다라면 bfin.read(readByte, 0, 4096) 은 -1 을 리턴시켜준다. 
				       그러므로  while( (length = bfin.read(readByte, 0, 4096)) != -1  ) 말은 
				       다운로드 해주어야할 file 을 매번 4096 byte 씩 읽어들인다는 말이다.      	
				 */
					
					souts.write(readByte, 0, length);
					/*
					    readByte 에 저장된 내용을 처음부터 읽어온 크기인 length 만큼  
					    ServletOutputStream souts 에 기록(저장)해둔다.
					 */
				}// end of while()----------------------------------
			
				souts.flush(); // ServletOutputStream souts 에 기록(저장)해둔 내용을 클라이언트로 내본다. 
			
				souts.close(); // ServletOutputStream souts 객체를 소멸시킨다.
				bfin.close();  // BufferedInputStream bfin 객체를 소멸시킨다.
				
				return true; // 다운로드 해줄 파일이 존재하고 Exception 이 발생하지 않으면 true 를 리턴시킨다. 
				
			} // end of if ------------------------------------	
				
		} catch(Exception e) { }
		
		return false;
	}
	
	
	// == 파일 삭제 하기 ==
	public void doFileDelete(String saveFilename, String path) throws Exception {
		
		String pathname = path + File.separator + saveFilename;
		
		File file = new File(pathname);
		
		if(file.exists()) {
			file.delete();
		}
	}
		
}






