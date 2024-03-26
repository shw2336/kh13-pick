package com.kh.rushpickme.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.rushpickme.configuration.SettingConfiguration;
import com.kh.rushpickme.dao.AttachDao;
import com.kh.rushpickme.dto.AttachDto;

@Controller
@RequestMapping("/download")

public class FileDownloadController {
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private SettingConfiguration sefc;
	@RequestMapping
	@ResponseBody
	public ResponseEntity<ByteArrayResource> download(@RequestParam int attachNo) throws IOException {
		
		// [1] attachNo로 파일 정보 불러오기 (AttachDto)
		AttachDto attachDto = attachDao.selectOne(attachNo);
		
		// [2] attachDto가 없으면 404 처리 
		if (attachDto == null) {
			return ResponseEntity.notFound().build();
		}
		
		// [3] 실제 파일을 불러온다 (apache commons io, apache commons fileupload)
		File dir = new File (sefc.getPath());
		File target = new File (dir, String.valueOf(attachDto.getAttachNo()));
		
		byte[] data = FileUtils.readFileToByteArray(target); 
		//파일을 읽어라 : apache commons 라이브러리가 있기 때문에 사용 가능 
		ByteArrayResource resource = new ByteArrayResource(data); 
		//포장 (데이터 래핑)
		
		// [4] attachDto에 있는 정보와, [3] 정보를 조합하여 사용자에게 반환 
		//		- 추가적인 정보를 제공해서 파일 다운로드 처리가 일어나도록 구현
		//		- 추가적인 정보는 header에 설정 "언어,타입,크기,파일명" (.ok()와 .body 사이에)
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(attachDto.getAttachSize())
				.header(HttpHeaders.CONTENT_DISPOSITION, 
						ContentDisposition.attachment()
						.filename(attachDto.getAttachName(), StandardCharsets.UTF_8)
						.build().toString())
				// 파일명이 유니코드여도 상관없게 설정
				.body(resource);
	}
}

