package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.dao.LogoDao;
import com.javaex.vo.FileVo;

@Service
public class LogoService {

	@Autowired
	LogoDao lDao;
	
	public String logoSelect(String id) {
		return lDao.logoSelect(id);
	}

	@Transactional
	public String logoChange(int userNo, MultipartFile file) {
		String fileSaveName = logoRestore(file);
		
		Map<String,Object> idAndFileSaveName = new HashMap<String,Object>();
		idAndFileSaveName.put("userNo", userNo);
		idAndFileSaveName.put("fileSaveName", fileSaveName);
		lDao.logoChange(idAndFileSaveName);
		return fileSaveName;
		
	}
	
	public String logoRestore(MultipartFile file) {
		//파일 정보 수집
		//저장 폴더
		String fielSaveDir = "c:/cho/upload";
		
		//원파일 이름
		String fileOriginalName= file.getOriginalFilename();
		System.out.println(fileOriginalName);
		
		//확장자
		String fileExName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		System.out.println(fileExName);
		
		//저장파일 이름
		String fileSaveName = System.currentTimeMillis() + UUID.randomUUID().toString() + fileExName;
		System.out.println(fileSaveName);
		
		//파일 위치(패스)
		String filePath = fielSaveDir + "/" + fileSaveName;
		System.out.println(filePath);
		
		//파일사이즈
		long fileSize = file.getSize();
		System.out.println(fileSize);
		
		
		//파일 카피
		try {
			byte[] fileData = file.getBytes();
			OutputStream out = new FileOutputStream(filePath); //저장위치
			BufferedOutputStream bout = new BufferedOutputStream(out);
			
			bout.write(fileData);
			
			if(bout != null) {
				bout.close();
			}
			
			FileVo fvo = new FileVo(fielSaveDir,fileOriginalName,fileExName,fileSaveName,filePath,fileSize);
			int result = lDao.logoFileInsert(fvo);
			
			System.out.println("logofiledata DB 저장 처리 결과 : " + result);
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return fileSaveName;
	}
}
