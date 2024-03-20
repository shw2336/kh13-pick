package com.kh.rushpickme.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.rushpickme.dao.BuyDao;
import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dao.PointDao;
import com.kh.rushpickme.dto.BuyDto;
import com.kh.rushpickme.dto.MemberGreenDto;
import com.kh.rushpickme.dto.PointDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/point")
public class PointController {
    @Autowired
    private PointDao pointDao;
    @Autowired
    private BuyDao buyDao;
    @Autowired
    private MemberDao memberDao;
    


    @GetMapping("/charge")
    public String charge(Model model) {
        model.addAttribute("list", pointDao.selectList());
        return "/WEB-INF/views/point/charge.jsp";
    }

    @PostMapping("/charge")
    public String charge(@ModelAttribute BuyDto buyDto, HttpSession session) {
        String loginId = (String)session.getAttribute("loginId");//아이디 추출
        PointDto pointDto = pointDao.selectOne(buyDto.getPointNo());//상품정보 조회

        buyDto.setMemberId(loginId);//아이디 설정
        buyDto.setPointName(pointDto.getPointName());//상품명 복사
        buyDto.setBuyTotal(pointDto.getPointSell() * buyDto.getBuyQty());//금액x수량

        buyDao.insert(buyDto);//구매내역 등록
        int item = pointDto.getPointSell() * buyDto.getBuyQty();
        memberDao.plusMemberPoint(loginId, item);//포인트 증가
     
        //기존 부름티켓 3장에서 포인트 구매시 차등지급되는 티켓수 증가
        MemberGreenDto memberGreenDto = memberDao.selectOneGreen(loginId);
        int changeTicket = memberGreenDto.getMemberGreenTicket() + memberGreenDto.getMemberGreenPoint() / 10000;
	    // 티켓 수 업데이트
	    memberDao.updateTicketsByGreenPoint(loginId, changeTicket);
        
        // green 회원의 포인트 구매 내역 저장
////        MemberGreenDto greenDto = new MemberGreenDto();
//        
//        greenDto.setMemberId(loginId);//아이디 설정
//        buyDto.setPointName(pointDto.getPointName());//상품명 복사
//        greenDto.setMemberGreenPoint(pointDto.getPointSell() * buyDto.getBuyQty());//금액x수량
        


        return "redirect:chargeFinish";
    }

    @RequestMapping("/chargeFinish")
    public String chargeFinish() {
        return "/WEB-INF/views/point/chargeFinish.jsp";
    }

    @RequestMapping("/image")
    public String image(@RequestParam int pointNo) {
        try {
            int attachNo = pointDao.findAttachNo(pointNo);
            return "redirect:/download?attachNo=" + attachNo;
        } catch(Exception e) {
            return "redirect:https://via.placeholder.com/200x100";
        }
    }
}
