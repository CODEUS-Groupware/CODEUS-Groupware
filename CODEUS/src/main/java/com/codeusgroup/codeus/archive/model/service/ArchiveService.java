package com.codeusgroup.codeus.archive.model.service;

import java.util.ArrayList;
import java.util.List;

import com.codeusgroup.codeus.archive.model.vo.ArchiveCapacity;
import com.codeusgroup.codeus.archive.model.vo.ArchiveFile;
import com.codeusgroup.codeus.archive.model.vo.ArchiveFolder;

public interface ArchiveService {

	List<ArchiveFolder> selectFolderList();

	List<ArchiveFile> selectFileList(Integer currentFolder);

	ArchiveCapacity selectArchiveCapacity();

	int insertTotalCapacity(long capacity);

	int updateTotalCapacity(long capacity);

	int insertArchiveFile(ArrayList<ArchiveFile> fList);

	int deleteFile(String[] archArr);

	int deleteFolder(int[] folderIdArr);

	int addFolder(ArchiveFolder folder);

	int renameFolder(ArchiveFolder folder);

	int moveFile(ArrayList<ArchiveFile> fileList);

	int moveFolder(ArrayList<ArchiveFolder> folderList);

	List<ArchiveFolder> selectHierarchicalfolderList();



}
