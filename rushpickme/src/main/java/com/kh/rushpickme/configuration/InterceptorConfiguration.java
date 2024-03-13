package com.kh.rushpickme.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.rushpickme.interceptor.QnaHitsInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{

	@Autowired
	private QnaHitsInterceptor qnaHitsInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
				
		//게시글 조회수 중복방지 인터셉터
		registry.addInterceptor(qnaHitsInterceptor).addPathPatterns("/qna/detail");
				
	}
}
