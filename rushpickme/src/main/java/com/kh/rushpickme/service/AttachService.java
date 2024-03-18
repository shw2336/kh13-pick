package com.kh.rushpickme.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.rushpickme.dao.AttachDao;
import com.kh.rushpickme.dto.AttachDto;

@Service
public class AttachService {

	@Autowired
	AttachDao attachDao;
	
	//파일저장 + DB저장 
	public int save(MultipartFile attach) throws IllegalStateException, IOException {
		
		int attachNo = attachDao.getSequence(); //첨부파일에 시퀀스생성
		File dir = new File (System.getProperty("user.home"), "upload");
		dir.mkdir(); //폴더가 없다면 생성 (있으면 pass)
		File target = new File (dir, String.valueOf(attachNo));
		attach.transferTo(target); //위에만들어준 폴더에 실물파일저장 
		//첨부파일 정보 DB저장
		AttachDto attachDto = new AttachDto();
		attachDto.setAttachNo(attachNo);
		attachDto.setAttachName(attach.getOriginalFilename());
		attachDto.setAttachType(attach.getContentType());
		attachDto.setAttachSize(attach.getSize());
		attachDao.insert(attachDto); //첨부파일 정보 DB 업로드 
		
		return attachNo;
	}
	//파일삭제 + DB삭제
	public void remove (int attachNo) {
		File dir = new File (System.getProperty("user.home"), "upload");
		File target = new File (dir, String.valueOf(attachNo));
		target.delete();
		attachDao.delete(attachNo);
	}
	
//	public void change(int attachNo, MultipartFile attach) throws IOException {
//	    	
//		 BufferedImage bufferedImage = ImageIO.read(attach.getInputStream()) ;
//		 int width = (int) (bufferedImage.getWidth() * 100) ;
//		 int height = (int) (bufferedImage.getHeight() * 100) ;
//		 BufferedImage resizedFile = Scalr.resize(bufferedImage
//		   , Scalr.Method.SPEED
//		   , Scalr.Mode.AUTOMATIC
//		   , width
//		   , height
//		   , Scalr.OP_ANTIALIAS)
//		   ;
//		 ImageIO.write(resizedFile
//		   , extension
//		   , 
//		   new 
//		   File(System.getProperty("user.home"), "upload"))
//		   ;
//		
//	}
//	
	
	
	
	
	
	
	
	
	
	
	
	
}
