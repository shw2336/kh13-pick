package com.kh.rushpickme.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.rushpickme.dao.ReviewDao;
import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dto.ReviewDto;
import com.kh.rushpickme.dto.ApplyDto;
import com.kh.rushpickme.dto.MemberDto;
import com.kh.rushpickme.service.AttachService;
import com.kh.rushpickme.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
	//게시판에서는 empty string으로 전달되는 파라미터를 null로 간주하도록 설정
	//@InitBinder 설정으로 구현
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	}
	

	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AttachService attachService;
	
//	@RequestMapping("/list")
//	public String list(
//			@RequestParam(required = false) String column, 
//			@RequestParam(required = false) String keyword,
//			@RequestParam(required = false, defaultValue = "1") int page,
//			@RequestParam(required = false, defaultValue = "10") int size,
//			Model model) {
//		boolean isSearch = column != null && keyword != null;
//		
//		/*
//			화면에 네비게이터를 보여주는 데 필요한 값들을 계산
//			- blockSize : 화면에 표시할 네비게이터 개수 (10으로 설정)
//			- beginBlock : 네비게이터의 처음 숫자 , (페이지-1) / 10 * 10 + 1 (10은 blockSize)
//			- endBlock : 네비게이터의 마지막 숫자 , (페이지-1) / 10 * 10 + 10 (10은 blockSize)
//			- count : 게시글 개수
//			- totalPage : 전체 페이지 개수
//		 */
//		int blockSize = 10;
//		int beginBlock = (page-1) / blockSize * blockSize + 1;
//		int endBlock = (page-1) / blockSize * blockSize + blockSize;
//		model.addAttribute("beginBlock", beginBlock);//네비게이터 시작번호
//		model.addAttribute("endBlock", endBlock);//네비게이터 종료번호
//		model.addAttribute("page", page);//현재 페이지 번호
//		
//		int count = isSearch ? 
//				reviewDao.count(column, keyword) : reviewDao.count();
//		int totalPage = (count - 1) / size + 1;
//		model.addAttribute("count", count);//게시글 개수
//		model.addAttribute("totalPage", totalPage);//총 페이지 수
//		
//		model.addAttribute("size", size);//현재 게시글 표시 개수
//		
//		if(isSearch) {
//			//model.addAttribute("list", reviewDao.selectList(column, keyword));
//			model.addAttribute("list", reviewDao.selectListByPaging(column, keyword, page, size));
//		}
//		else {
//			//model.addAttribute("list", reviewDao.selectList());
//			model.addAttribute("list", reviewDao.selectListByPaging(page, size));
//		}
//		return "/WEB-INF/views/review/list.jsp";
//	}
	
//	Paging 처리를 별도의 VO 클래스로 구현
//	(참고) @ModelAttribute에 옵션을 주면 자동으로 모델에 첨부된다
	@RequestMapping("/list")
	public String list(
			@ModelAttribute PageVO pageVO,
			Model model) {
		//세부 계산은 클래스에서 수행하도록 하고 count, list만 처리
		int count = reviewDao.count(pageVO);
		pageVO.setCount(count);
		model.addAttribute("pageVO", pageVO);
		
		List<ReviewDto> list = reviewDao.selectListByPaging(pageVO);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/review/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int reviewNo, Model model) {
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		model.addAttribute("reviewDto", reviewDto);
		//조회한 게시글 정보에 있는 회원 아이디로 작성자 정보를 불러와서 첨부
		if(reviewDto.getMemberId() != null) {//작성자가 탈퇴하지 않았다면
			MemberDto memberDto = memberDao.selectOne(reviewDto.getMemberId());
			model.addAttribute("memberDto", memberDto);
		}
		return "/WEB-INF/views/review/detail.jsp";
	}
	
	@GetMapping("/write")
	public String write(@ModelAttribute ReviewDto reviewDto, Model model) {
		int askNo = reviewDto.getAskNo();
		model.addAttribute("askNo", askNo);
		return "/WEB-INF/views/review/write.jsp";
	}
	@PostMapping("/write")
	public String write(@ModelAttribute ReviewDto reviewDto, HttpSession session,
					@RequestParam float score, @ModelAttribute ApplyDto applyDto, Model model) {
		//세션에서 로그인한 사용자의 ID를 추출
		String loginId = (String)session.getAttribute("loginId");
		//아이디를 게시글 정보에 포함시킨다
		reviewDto.setMemberId(loginId);
		int reviewStar = (int)score;
		reviewDto.setReviewStar(reviewStar);
		int sequence = reviewDao.getSequence();//DB에서 시퀀스 번호를 추출
		reviewDto.setReviewNo(sequence);//게시글 정보에 추출한 번호를 포함시킨다
		reviewDao.insert(reviewDto);//등록
		
		return "redirect:detail?reviewNo="+sequence;
	}
	
	
	@GetMapping("/delete")
	public String delete(@RequestParam int reviewNo) {
		//(summernote 관련 추가할 내용)
		//- 글을 지우면 첨부파일이 좀비가 된다
		//- 글과 첨부파일이 연결되어 있지 않다
		//- 글 내용을 찾아서 사용된 이미지 번호를 뽑아 모두 삭제하도록 구현
		//- DB를 활용하는 것이 아닌 프로그래밍으로 처리하는 방식
		//- 글 안에 있는 <img> 중에 .server-img를 찾아서 data-key를 읽어 삭제
		//- (문제점) Java에서 HTML 구조를 탐색(해석)할 수 있나? OK (Jsoup)
		
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		
		//Jsoup으로 내용을 탐색하는 과정
		Document document = Jsoup.parse(reviewDto.getReviewContent());
		Elements elements = document.select(".server-img");//태그 찾기
		for(Element element : elements) {//반복문으로 한개씩 처리
			String key = element.attr("data-key");//data-key 속성을 읽어라!
			int attachNo = Integer.parseInt(key);//숫자로 변환
			attachService.remove(attachNo);//파일삭제+DB삭제
		}
		
		reviewDao.delete(reviewNo);
		//return "redirect:/review/list";
		return "redirect:list";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int reviewNo, Model model) {
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		model.addAttribute("reviewDto", reviewDto);
		return "/WEB-INF/views/review/edit.jsp";
	}

	@PostMapping("/edit")
	public String edit(@ModelAttribute ReviewDto reviewDto, HttpSession session,
			@RequestParam float score) {
		
		//세션에서 로그인한 사용자의 ID를 추출
				String loginId = (String)session.getAttribute("loginId");
				
				//아이디를 게시글 정보에 포함시킨다
				reviewDto.setMemberId(loginId);
				reviewDto.setAskNo(4);
				int reviewStar = (int)score;
				reviewDto.setReviewStar(reviewStar);
				
		//수정 전,후를 비교하여 사라진 이미지를 찾아 삭제
		//- 수정 전 이미지 그룹과 수정 후 이미지의 차집합(Set 사용)
		
		//기존 글 조회하여 수정 전 이미지 그룹을 조사
		Set<Integer> before = new HashSet<>();
		ReviewDto findDto = reviewDao.selectOne(reviewDto.getReviewNo());
		Document doc = Jsoup.parse(findDto.getReviewContent());//해석
		for(Element el : doc.select(".server-img")) {//태그 찾아서 반복
			String key = el.attr("data-key");//data-key 추출
			int attachNo = Integer.parseInt(key);//숫자로 변환
			before.add(attachNo);//저장
		}
		
		//수정한 글 조사하여 수정 후 이미지 그룹을 조사
		Set<Integer> after = new HashSet<>();
		doc = Jsoup.parse(reviewDto.getReviewContent());//해석
		for(Element el : doc.select(".server-img")) {//태그 찾아서 반복
			String key = el.attr("data-key");//data-key 추출
			int attachNo = Integer.parseInt(key);//숫자로 변환
			after.add(attachNo);//저장
		}
		
		//before에만 있는 번호를 찾아서 모두 삭제
		before.removeAll(after);
		
		//before에 남은 번호에 대한 이미지를 모두 삭제
		for(int attachNo : before) {
			attachService.remove(attachNo);
		}
		
		reviewDao.update(reviewDto);
		return "redirect:detail?reviewNo="+reviewDto.getReviewNo();
	}
	
}