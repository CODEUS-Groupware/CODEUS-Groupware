package com.codeusgroup.codeus.archive.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.codeusgroup.codeus.archive.model.dao.ArchiveDAO;
import com.codeusgroup.codeus.archive.model.vo.ArchiveCapacity;
import com.codeusgroup.codeus.archive.model.vo.ArchiveFile;
import com.codeusgroup.codeus.archive.model.vo.ArchiveFolder;

@Service("archService")
public class ArchiveServiceImpl implements ArchiveService {

	@Autowired
	private ArchiveDAO archDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<ArchiveFolder> selectFolderList() {
		return archDAO.selectFolderList(sqlSession);
	}
	

	@Override
	public List<ArchiveFolder> selectHierarchicalfolderList() {
		return archDAO.selectHierarchicalfolderList(sqlSession);
	}
	
	@Override
	public List<ArchiveFile> selectFileList(Integer currentFolder) {
		return archDAO.selectFileList(sqlSession, currentFolder);
	}

	@Override
	public ArchiveCapacity selectArchiveCapacity() {
		return archDAO.selectArchiveCapacity(sqlSession);
	}

	@Override
	public int insertTotalCapacity(long capacity) {
		return archDAO.insertTotalCapacity(sqlSession, capacity);
	}

	@Override
	public int updateTotalCapacity(long capacity) {
		return archDAO.updateTotalCapacity(sqlSession, capacity);
	}

	@Override
	@Transactional
	public int insertArchiveFile(ArrayList<ArchiveFile> fList) {
		
		int result = 0;
		result = archDAO.insertArchiveFile(sqlSession, fList);
		
		long totalSize = 0;
		for(ArchiveFile f : fList) {
			totalSize += f.getSize();
		}
		
		int result2 = 0;
		if (result >= fList.size()) {
			result2 = archDAO.updateCurrCapacity(sqlSession, totalSize);
		}
		
		return result + result2;
	}

	@Override
	@Transactional
	public int deleteFile(String[] archArr) {
		
		int result1 = 0;
		result1 = archDAO.deleteFile(sqlSession, archArr);
		
		long totalSize = 0;
		for (String a : archArr) {
			String[] archive = a.split("/");
			totalSize += Long.parseLong(archive[1]);
			
		}
		
		int result2 = 0;
		result2 = archDAO.reduceCurrCapacity(sqlSession, totalSize);
		
		return result1 + result2;
	}

	@Override
	@Transactional
	public int deleteFolder(int[] folderIdArr,  String[] subFileArr) {
		
		int result = 0;
		if (subFileArr == null) {
			// 삭제할 폴더 내부파일이 없었다면 폴더만 삭제
			result = archDAO.deleteFolder(sqlSession, folderIdArr);
			
		} else {
			// 삭제할 폴더 내부에 파일이 존재했다면
			// delteFile메소드를 호출해 파일을 삭제
			result = deleteFile(subFileArr);
			
			// 파일 삭제 후 폴더 용량 수정까지 완료됐다면 폴더 삭제
			if (result >= subFileArr.length + 1) { 
				result = archDAO.deleteFolder(sqlSession, folderIdArr);
			} else {
				result = 0;
			}
		}
		
		return result;
	}

	@Override
	public int addFolder(ArchiveFolder folder) {
		return archDAO.addFolder(sqlSession, folder);
	}

	@Override
	public int renameFolder(ArchiveFolder folder) {
		return archDAO.renameFolder(sqlSession, folder);
	}

	@Override
	public int moveFile(ArrayList<ArchiveFile> fileList) {
		return archDAO.moveFile(sqlSession, fileList);
	}

	@Override
	public int moveFolder(ArrayList<ArchiveFolder> folderList) {
		return archDAO.moveFolder(sqlSession, folderList);
	}


	@Override
	public List<ArchiveFile> selectDeleteFileList(int[] folderIdArr) {
		return archDAO.selectDeleteFileList(sqlSession, folderIdArr);
	}

}
