<h1>스프링을 활용한 간단한 게시판 프로젝트</h1>
  스프링을 이용하여 간단한 게시판을 만들어 보았습니다.
  
  <h2>프로젝트 개발 환경</h2>
  <ul>
    <li>운영체제 : 윈도우 11</li>
    <li>통합개발환경(IDE) : Intellij</li>
    <li>JDK버전 : JDK 11</li>
    <li>스프링 버전 : 5.0.7</li>
    <li>데이터베이스 : MySQL</li>
    <li>빌드 툴 : Maven</li>
  </ul>
  <h2>기술 스택</h2>
  <ul>
    <li>프론트 엔드 : HTML, CSS, JS, jQuery, BootStrap</li>
    <li>백엔드 : Java, Spring</li>
    <li>데이터베이스 : MySQL, MyBatis</li>
  </ul>
  <h2>구현 기능</h2>
  <ul>
    <li>회원가입 - Validator 및 자바스크립트를 이용하여 유효성 검사 진행</li>
    <li>로그인 : 유효성검사, 쿠키를 통한 아이디 기억 구현</li>
    <li>게시판 : CRUD 구현</li>
    <li>검색과 페이징 : 검색 조건 추가 및 페이징 기능 구현</li>
    <li>댓글과 덧글 : CRUD 구현</li>
  </ul>
    <h2>기능 설명</h2>
    <ol>
      <h3><li>메인화면</li></h3>
      <img src="https://github.com/DevelopIsHobby/MyPortfolio/assets/107912101/ec5062e3-2355-43ab-8f68-4caa758e586d">
      <h3><li>회원가입 화면</li></h3>
      <img src="https://github.com/DevelopIsHobby/MyPortfolio/assets/107912101/0cfaae48-2b2f-4c47-acd9-fde322ccc54a">
      <ul><li>[submit]버튼을 클릭하면 유효성 검사를 진행한다.</li></ul>      
      <h3><li>로그인 화면</li></h3>
      <img src="https://github.com/DevelopIsHobby/MyPortfolio/assets/107912101/ef1647b1-b35a-452d-9ec6-550dd9c024e2">
      <ul>
        <li>[submit]버튼을 클릭하면 유효성 검사를 진행한다.</li>
        <li>쿠키를 통해 아이디 기억기능을 구현하였다.</li>
      </ul> 
      <h3><li>게시판 목록 화면</li></h3>
      <img src="https://github.com/DevelopIsHobby/MyPortfolio/assets/107912101/d403617b-b5bf-46fa-86f6-7a9c411c7c88">
      <ul>
        <li>세션을 통해 로그인 상태를 유지하여, 로그인 하지 않은 상태로는 게시판 화면에 접근할 수 없다.</li>
        <li>키워드를 통한 검색조건에 따른 검색기능을 추가하였고, 페이징 기능을 구현하였다.</li>
        <li>게시글의 제목을 클릭함으로써 게시글에 접근할 수 있다.</li>
      </ul>
      <h3><li>게시글 화면</li></h3>
      <img src="https://github.com/DevelopIsHobby/MyPortfolio/assets/107912101/c10dcf7b-4362-4a0f-bed8-873eb63e0f0f">
      <h4>게시글의 기본적인 기능</h4>
        <ul>
          <li>현재 화면에서는 게시글을 읽기만 할 수 있다.</li>
          <li>글쓰기 버튼 클릭 - 새로운 게시글 화면으로 이동한다.</li>
          <li>수정 버튼 클릭 - 현재 게시판을 수정한다.</li>
          <li>목록 버튼 클릭 - 이전에 있었던 화면으로 이동한다.</li>
          <li>삭제 버튼 클릭 - 현재 게시글을 삭제한다.</li>
        </ul>
        <h4>댓글&덧글 기능</h4>
        <img src="https://github.com/DevelopIsHobby/MyPortfolio/assets/107912101/087983b1-571a-43d9-b501-fbda3674d4fa">
        <ul>
          <li>댓글등록버튼 클릭 - 새로운 댓글을 등록한다.</li>
          <li>수정버튼 클릭 - 현재 댓글을 수정한다.</li>
          <li>삭제버튼 클릭 - 현재 댓글을 삭제한다.</li>
          <li>수정버튼 클릭 - 현재 댓글을 수정한다.</li>
          <li>답글버튼 클릭 - 현재 댓글의 답글을 입력한다. -> 새로운 답글은 현재 댓글 바로 아래에 추가된다.</li>
          <img src="https://github.com/DevelopIsHobby/MyPortfolio/assets/107912101/51ad69c8-0fac-4069-91bb-f863dd8fc07e">
        </ul>
      </div>
    </ol>
  <h2>소감</h2>
    <li>코드를 짜면서 헷갈렸던 뷰와 컨트롤 사이의 데이터 전달을 명확하게 알 수 있었고, JSP에서 EL과 JSTL을 사용하는데에도 익숙해진 것 같다.</li>
    <li>댓글 및 덧글 기능은 AJAX를 이용하는 것이 순수 자바스크립트로 이용하는 것보다 훨씬 편하다.</li>
    <li>유효성 검사가 조잡하고, 대댓글 UI가 아쉽다. 파일첨부도 할 수 있었으면 더 좋았을 듯듯</li>
