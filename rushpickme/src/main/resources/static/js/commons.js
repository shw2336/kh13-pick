// 사용자에게 물어보고 확인을 누르면 이동하는 링크 구현
// 메시지는 설정할 수도 있고 하지 않을 수도 있으며,
// 하지 않은 경우 기본메시지 출력 
// a 태그에 .link-confirm을 추가하면 기본메시지가 출력되는 확인링크 생성
// 생성한 태그에 data-message 속성 추가하여 확인창의 멘트 설정

$(function(){
    $("a.link-confirm").click(function(){
        var message = $(this).data("message");
        if (message == undefined) {
            message = "정말 이동하시겠습니까?";
        }
        var choice = window.confirm(message);
        return choice;
    });
});

/*
    전체선택 체크박스에 대한 이벤트 구현
    - .check-all은 전체 선택 체크박스
    - .check-item은 개별 항목 체크박스
    - jquery에서는 태그의 속성을 .prop() 명령으로 제어 또는 확인 
*/
    $(function(){
        // 전체선택 체크박스에 입력이 발생하면, 확인하여 개별항목에 반영
        // $(".check-all").on("input", function(){});
        $(".check-all").change(function(){
            var checked = $(this).prop("checked"); 
            // jQuery , prop : 속성을 뜻함, checked속성 / true 또는 false로 반환됨
            $(".check-item").prop("checked", checked);   //개별항목 체크변경
            $(".check-all").prop("checked", checked); //전체항목 체크변경
        });

        $(".check-item").change(function(){
            // 총 ?개 중 ?개가 선택되었는지를 파악하여 처리
            var countAll = $(".check-item").length; //  "check-item"인 모든 요소의 수
            var countChecked = $(".check-item:checked").length; // 클래스가 "check-item"이면서 체크된 상태인 요소의 수

            var allChecked = countAll == countChecked;
            $(".check-all").prop("checked", allChecked);
             // allChecked가 true면 check-all 클래스의 checked 속성을 true(존재한다) 로
        });
    });

    /*
    멀티페이지 모듈
    - div를 연속 배치하고 .page를 부여하면 멀티페이지가 됨
    - .page 내부에 .btn-prev와 .btn-next를 배치하여 이동버튼을 구현
    - 첫번째 이전버튼과, 마지막 다음버튼은 자동제거되므로 반드시 만들 것 
*/

    $(function(){

        $(".page").hide();
        $(".page").first().show();

        // [추가] 첫번째 이전버튼과 마지막 다음버튼을 삭제 : 태그삭제명령 .remove()
        // 외부코드와의 충돌을 방지하기위해, 
        //  ".page" 클래스를 가진 요소 안에서
        // ".btn-prev" 클래스를 가진 첫 번째 요소와 ".btn-next" 클래스를 가진 마지막 요소를 삭제
        $(".page").find(".btn-prev").first().remove(); 
        $(".page").find(".btn-next").last().remove();

        $(".btn-next").click(function(){
            $(this).parents(".page").hide().next(".page").show();
        });
        $(".btn-prev").click(function(){
            $(this).parents(".page").hide().prev(".page").show(); // 페이지 내부에 버튼이 있으면 작동
        });

    });