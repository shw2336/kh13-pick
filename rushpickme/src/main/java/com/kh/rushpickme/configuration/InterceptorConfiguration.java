package com.kh.rushpickme.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.rushpickme.interceptor.QnaHitsInterceptor;
import com.kh.rushpickme.interceptor.ReviewHitsInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{

	@Autowired
	private QnaHitsInterceptor qnaHitsInterceptor;
	
	@Autowired
	private ReviewHitsInterceptor reviewHitsInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
				
		//게시글 조회수 중복방지 인터셉터
		registry.addInterceptor(qnaHitsInterceptor).addPathPatterns("/qna/detail");
				
		//리뷰 조회수 중복방지 인터셉터
		registry.addInterceptor(reviewHitsInterceptor).addPathPatterns("/review/detail");
	}
}
