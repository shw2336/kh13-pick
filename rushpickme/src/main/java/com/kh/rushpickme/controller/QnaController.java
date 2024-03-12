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
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.rushpickme.dao.QnaDao;
import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dto.QnaDto;
import com.kh.rushpickme.dto.MemberDto;
import com.kh.rushpickme.service.AttachService;
import com.kh.rushpickme.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/qna")
public class QnaController {
	
	//게시판에서는 empty string으로 전달되는 파라미터를 null로 간주하도록 설정
	//@InitBinder 설정으로 구현
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	}
	

	@Autowired
	private QnaDao qnaDao;
	
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
//				qnaDao.count(column, keyword) : qnaDao.count();
//		int totalPage = (count - 1) / size + 1;
//		model.addAttribute("count", count);//게시글 개수
//		model.addAttribute("totalPage", totalPage);//총 페이지 수
//		
//		model.addAttribute("size", size);//현재 게시글 표시 개수
//		
//		if(isSearch) {
//			//model.addAttribute("list", qnaDao.selectList(column, keyword));
//			model.addAttribute("list", qnaDao.selectListByPaging(column, keyword, page, size));
//		}
//		else {
//			//model.addAttribute("list", qnaDao.selectList());
//			model.addAttribute("list", qnaDao.selectListByPaging(page, size));
//		}
//		return "/WEB-INF/views/qna/list.jsp";
//	}
	
//	Paging 처리를 별도의 VO 클래스로 구현
//	(참고) @ModelAttribute에 옵션을 주면 자동으로 모델에 첨부된다
	@RequestMapping("/list")
	public String list(
			@ModelAttribute PageVO pageVO,
			Model model) {
		//세부 계산은 클래스에서 수행하도록 하고 count, list만 처리
		int count = qnaDao.count(pageVO);
		pageVO.setCount(count);
		model.addAttribute("pageVO", pageVO);
		
		List<QnaDto> list = qnaDao.selectListByPaging(pageVO);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/qna/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int qnaNo, Model model) {
		QnaDto qnaDto = qnaDao.selectOne(qnaNo);
		model.addAttribute("qnaDto", qnaDto);
		//조회한 게시글 정보에 있는 회원 아이디로 작성자 정보를 불러와서 첨부
		if(qnaDto.getMemberId() != null) {//작성자가 탈퇴하지 않았다면
			MemberDto memberDto = memberDao.selectOne(qnaDto.getMemberId());
			model.addAttribute("memberDto", memberDto);
		}
		return "/WEB-INF/views/qna/detail.jsp";
	}
	
	@GetMapping("/write")
	public String write(
			@RequestParam(required = false) Integer qnaTarget,
			Model model) {
//		답글일 경우는 작성 페이지로 답글의 정보를 전달(제목 등에 사용)
		if(qnaTarget != null) {
			QnaDto targetDto = qnaDao.selectOne(qnaTarget);
			model.addAttribute("targetDto", targetDto);
		}
		return "/WEB-INF/views/qna/write.jsp";
	}
	
//	@PostMapping("/write")
//	public String write(@ModelAttribute qnaDto qnaDto, HttpSession session) {
//		//세션에서 로그인한 사용자의 ID를 추출
//		String loginId = (String)session.getAttribute("loginId");
//		
//		//아이디를 게시글 정보에 포함시킨다
//		qnaDto.setqnaWriter(loginId);
//		
//		int sequence = qnaDao.getSequence();//DB에서 시퀀스 번호를 추출
//		qnaDto.setqnaNo(sequence);//게시글 정보에 추출한 번호를 포함시킨다
//		qnaDao.insert(qnaDto);//등록
//		
//		return "redirect:detail?qnaNo="+sequence;
//	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute QnaDto qnaDto, HttpSession session) {
//		새글과 답글을 구분하여 처리
//		- 구분 기준은 qnaDto에 qnaTarget 유무(있으면 답글, 없으면 새글)
//		- 새글이면 그룹번호=글번호, 대상=null, 차수=0
//		- 답글이면 그룹번호=원본글그룹번호, 대상=원본글번호, 차수=원본글차수+1
		
//		새글이든 답글이든 작성자는 있어야 한다
		String loginId = (String)session.getAttribute("loginId");
		qnaDto.setMemberId(loginId);
		
//		글번호를 생성하여 설정해준다
		int sequence = qnaDao.getSequence();
		qnaDto.setQnaNo(sequence);
		
//		새글,답글에 따른 그룹,대상,차수를 계산한다
		if(qnaDto.getQnaTarget() == null) {//새글(대상 == null)
			qnaDto.setQnaGroup(sequence);//그룹번호는 글번호로 설정
//			qnaDto.setqnaTarget(null);//대상은 null로 설정
//			qnaDto.setqnaDepth(0);//차수는 0으로 설정
		}
		else {//답글(대상 != null)
			//대상글의 모든 정보를 조회
			QnaDto targetDto = qnaDao.selectOne(qnaDto.getQnaTarget());
			
			qnaDto.setQnaGroup(targetDto.getQnaGroup());//그룹번호를 대상글의 그룹번호로 설정
//			qnaDto.setqnaTarget(targetDto.getqnaNo());
			qnaDto.setQnaDepth(targetDto.getQnaDepth() + 1);//차수를 대상글의 차수+1 로 설정
		}
		
//		계산이 완료된 정보를 이용하여 새글과 답글 모두 같은 메소드로 등록
		qnaDao.insert(qnaDto);
		
		return "redirect:detail?qnaNo="+sequence;
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam int qnaNo) {
		//(summernote 관련 추가할 내용)
		//- 글을 지우면 첨부파일이 좀비가 된다
		//- 글과 첨부파일이 연결되어 있지 않다
		//- 글 내용을 찾아서 사용된 이미지 번호를 뽑아 모두 삭제하도록 구현
		//- DB를 활용하는 것이 아닌 프로그래밍으로 처리하는 방식
		//- 글 안에 있는 <img> 중에 .server-img를 찾아서 data-key를 읽어 삭제
		//- (문제점) Java에서 HTML 구조를 탐색(해석)할 수 있나? OK (Jsoup)
		
		QnaDto qnaDto = qnaDao.selectOne(qnaNo);
		
		//Jsoup으로 내용을 탐색하는 과정
		Document document = Jsoup.parse(qnaDto.getQnaContent());
		Elements elements = document.select(".server-img");//태그 찾기
		for(Element element : elements) {//반복문으로 한개씩 처리
			String key = element.attr("data-key");//data-key 속성을 읽어라!
			int attachNo = Integer.parseInt(key);//숫자로 변환
			attachService.remove(attachNo);//파일삭제+DB삭제
		}
		
		qnaDao.delete(qnaNo);
		//return "redirect:/qna/list";
		return "redirect:list";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int qnaNo, Model model) {
		QnaDto qnaDto = qnaDao.selectOne(qnaNo);
		model.addAttribute("qnaDto", qnaDto);
		return "/WEB-INF/views/qna/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute QnaDto qnaDto) {
		//수정 전,후를 비교하여 사라진 이미지를 찾아 삭제
		//- 수정 전 이미지 그룹과 수정 후 이미지의 차집합(Set 사용)
		
		//기존 글 조회하여 수정 전 이미지 그룹을 조사
		Set<Integer> before = new HashSet<>();
		QnaDto findDto = qnaDao.selectOne(qnaDto.getQnaNo());
		Document doc = Jsoup.parse(findDto.getQnaContent());//해석
		for(Element el : doc.select(".server-img")) {//태그 찾아서 반복
			String key = el.attr("data-key");//data-key 추출
			int attachNo = Integer.parseInt(key);//숫자로 변환
			before.add(attachNo);//저장
		}
		
		//수정한 글 조사하여 수정 후 이미지 그룹을 조사
		Set<Integer> after = new HashSet<>();
		doc = Jsoup.parse(qnaDto.getQnaContent());//해석
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
		
		qnaDao.update(qnaDto);
		return "redirect:detail?qnaNo="+qnaDto.getQnaNo();
	}
	
}







