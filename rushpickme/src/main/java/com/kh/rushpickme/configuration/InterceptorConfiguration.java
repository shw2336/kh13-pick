package com.kh.rushpickme.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

//import com.kh.rushpickme.interceptor.AdminInterceptor;
import com.kh.rushpickme.interceptor.ReviewOwnerInterceptor;
import com.kh.rushpickme.interceptor.QnaOwnerInterceptor;
import com.kh.rushpickme.interceptor.MemberInterceptor;
import com.kh.rushpickme.interceptor.PickInterceptor;
import com.kh.rushpickme.interceptor.QnaHitsInterceptor;
import com.kh.rushpickme.interceptor.ReviewHitsInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
	
	@Autowired
	private MemberInterceptor memberInterceptor;
	
	@Autowired
	private QnaHitsInterceptor qnaHitsInterceptor;
	
	@Autowired
	private ReviewHitsInterceptor reviewHitsInterceptor;
	
	//@Autowired
	//private AdminInterceptor adminInterceptor;
	
	@Autowired
	private ReviewOwnerInterceptor reviewOwnerInterceptor;
	
	@Autowired
	private QnaOwnerInterceptor qnaOwnerInterceptor;
	
	@Autowired
	private PickInterceptor pickInterceptor;
	
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
//		registry에다가 인터셉터를 주소와 함께 등록
//		registry.addInterceptor(인터셉터객체).addPathPatterns(주소);
//		registry.addInterceptor(testInterceptor)
//					.addPathPatterns("/**");
		
//		지정한 페이지만 허용하도록 설정
//		registry.addInterceptor(memberInterceptor)
//					.addPathPatterns(
//							"/member/mypage", 
//							"/member/password", "/member/passwordFinish",
//							"/member/change",
//							"/member/exit"
//					);
		
//		중간주소를 등록하고 특정 페이지를 제외(exclude)
//		- 주소를 설정할 때 **와 *를 사용할 수 있다
//		- **는 하위 엔드포인트까지 모두 포함하여 설정할 때 사용 (후손)
//		- *는 동일 엔드포인트까지만 포함하여 설정할 때 사용 (자식)
		registry.addInterceptor(memberInterceptor)
					.addPathPatterns(
						"/member/",
						"/qna/**",
						"/review/**",
						//"/point/**",
						"/pick/**",
						"/rest/review_like/toggle"
					)
					.excludePathPatterns(
						//"/member/join", "/member/joinFinish",
						"/member/join*",
						"/member/login", "/member/exitFinish",
						"/member/find*",
						"/qna/list", "/qna/detail",
						"/review/list", "/review/detail"
					);
		
		//관리자 인터셉터 등록
		//registry.addInterceptor(adminInterceptor)
					//.addPathPatterns("/admin/**");
		
		//게시글 조회수 중복방지 인터셉터 등록
		registry.addInterceptor(reviewHitsInterceptor)
					.addPathPatterns("/review/detail");
		
		//게시글 조회수 중복방지 인터셉터 등록
		registry.addInterceptor(qnaHitsInterceptor)
					.addPathPatterns("/qna/detail");
		
		//내글 또는 관리자만 수정 삭제하는 인터셉터 등록
		registry.addInterceptor(qnaOwnerInterceptor)
					.addPathPatterns("/qna/edit", "/qna/delete");
		
		//내글 또는 관리자만 수정 삭제하는 인터셉터 등록
		registry.addInterceptor(reviewOwnerInterceptor)
					.addPathPatterns("/review/edit", "/review/delete");
		
		//피커만 접근 가능
		registry.addInterceptor(pickInterceptor).addPathPatterns("/pick/**");
	}
}
