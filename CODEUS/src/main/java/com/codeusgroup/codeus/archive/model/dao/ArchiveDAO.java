package com.codeusgroup.codeus.archive.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.archive.model.vo.ArchiveCapacity;
import com.codeusgroup.codeus.archive.model.vo.ArchiveFile;
import com.codeusgroup.codeus.archive.model.vo.ArchiveFolder;

@Repository("archDAO")
public class ArchiveDAO {

	public List<ArchiveFolder> selectFolderList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("archiveMapper.selectFolderList");
	}

	public List<ArchiveFolder> selectHierarchicalfolderList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("archiveMapper.selectHierarchicalfolderList");
	}
	
	public List<ArchiveFile> selectFileList(SqlSessionTemplate sqlSession, Integer currentFolder) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("currentFolder", currentFolder);
		return sqlSession.selectList("archiveMapper.selectFileList", map);
	}

	public ArchiveCapacity selectArchiveCapacity(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("archiveMapper.selectArchiveCapacity");
	}

	public int insertTotalCapacity(SqlSessionTemplate sqlSession, long capacity) {
		return sqlSession.insert("archiveMapper.insertTotalCapacity", capacity);
	}

	public int updateTotalCapacity(SqlSessionTemplate sqlSession, long capacity) {
		return sqlSession.update("archiveMapper.updateTotalCapacity", capacity);
	}

	public int insertArchiveFile(SqlSessionTemplate sqlSession, ArrayList<ArchiveFile> fList) {
		int result = 0;
		for (ArchiveFile f : fList) {
			result += sqlSession.insert("archiveMapper.insertArchiveFile", f);
		}
		
		return result;
	}

	public int updateCurrCapacity(SqlSessionTemplate sqlSession, long totalSize) {
		return sqlSession.update("archiveMapper.updateCurrCapacity", totalSize);
	}

	public int deleteFile(SqlSessionTemplate sqlSession, String[] archArr) {
		
		int result = 0;
		for (String a : archArr) {
			int archNo = Integer.parseInt(a.split("/")[0]);
			result += sqlSession.update("archiveMapper.deleteFile", archNo);
		}
		
		return result;
	}

	public int deleteFolder(SqlSessionTemplate sqlSession, int[] folderIdArr) {
		
		int result = 0;
		for (int folderId : folderIdArr) {
			result += sqlSession.delete("archiveMapper.deleteFolder", folderId);
		}
		
		return result;
	}

	public int reduceCurrCapacity(SqlSessionTemplate sqlSession, long totalSize) {
		return sqlSession.update("archiveMapper.reduceCurrCapacity", totalSize);
	}

	public int addFolder(SqlSessionTemplate sqlSession, ArchiveFolder folder) {
		return sqlSession.insert("archiveMapper.addFolder", folder);
	}

	public int renameFolder(SqlSessionTemplate sqlSession, ArchiveFolder folder) {
		return sqlSession.update("archiveMapper.renameFolder", folder);
	}

	public int moveFile(SqlSessionTemplate sqlSession, ArrayList<ArchiveFile> fileList) {
		
		int result = 0;
		for (ArchiveFile f : fileList) {
			result += sqlSession.update("archiveMapper.moveFile", f);
		}
		
		return result;
	}

	public int moveFolder(SqlSessionTemplate sqlSession, ArrayList<ArchiveFolder> folderList) {
		
		int result = 0;
		for (ArchiveFolder f : folderList) {
			result += sqlSession.update("archiveMapper.moveFolder", f);
		}
		
		return result;
	}

	public List<ArchiveFile> selectDeleteFileList(SqlSessionTemplate sqlSession, int[] folderIdArr) {
		
		return sqlSession.selectList("archiveMapper.selectDeleteFileList", folderIdArr);
	}

}
