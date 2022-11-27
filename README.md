# 🌆 FOR-WORKS 포웍스
> 업무용 그룹웨어 프로젝트

<br>

## 1. 제작 기간 & 참여인원
- 2022.09.15 ~ 2022.11.14
- 팀프로젝트, 6명
- [팀 깃허브](https://github.com/eunn-jin/ForWorks)

<br>

## 2. 사용 기술
#### :pushpin: `Back-end`
<div> 
  <img src="https://img.shields.io/badge/java 11-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <img src="https://img.shields.io/badge/spring 2.3.22-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <img src="https://img.shields.io/badge/oracle XE 21c-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <img src="https://img.shields.io/badge/jsp-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <img src="https://img.shields.io/badge/mybatis-eeeeee?style=for-the-badge&logo=&logoColor=white">
</div>

#### :pushpin: `Front-end`
<div>
  <img src="https://img.shields.io/badge/html5-eeeeee?style=for-the-badge&logo=&logoColor=white"> 
  <img src="https://img.shields.io/badge/css3-eeeeee?style=for-the-badge&logo=&logoColor=white"> 
  <img src="https://img.shields.io/badge/javascript-eeeeee?style=for-the-badge&logo=&logoColor=black"> 
  <img src="https://img.shields.io/badge/jquery 3.6-eeeeee?style=for-the-badge&logo=&logoColor=white">
</div>

#### :pushpin: `Server`
<div>
   <img src="https://img.shields.io/badge/apache tomcat 9.0-eeeeee?style=for-the-badge&logo=&logoColor=white">
</div>

#### :pushpin: `Tools / Libraries`
<div>
  <img src="https://img.shields.io/badge/sts 3.9.18-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <img src="https://img.shields.io/badge/VSCode 1.70.2-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <img src="https://img.shields.io/badge/SqlDeveloper 21.4.3-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <img src="https://img.shields.io/badge/SourceTree 3.4.8-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <br>
  <img src="https://img.shields.io/badge/github-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <img src="https://img.shields.io/badge/git-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <img src="https://img.shields.io/badge/ERDCloud-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <img src="https://img.shields.io/badge/Figma-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <br>
  <img src="https://img.shields.io/badge/ajax 2.8.9-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <img src="https://img.shields.io/badge/bootstrap 5-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <img src="https://img.shields.io/badge/lombok-eeeeee?style=for-the-badge&logo=&logoColor=white">
  <img src="https://img.shields.io/badge/el jstl-eeeeee?style=for-the-badge&logo=&logoColor=white">
</div>

<br>

## 3. 프로젝트 소개
기업 구성원들을 위한 협업툴입니다.  <br>
기업에 필요한 구성원과 업무를 위한 기능들을 한 곳에서 모두 지원하여 편의성을 제공하고, 업무를 공유하고 관리할 수 있는 공간을 만들어 업무의 효율성을 높이며 기업 업무에 대한 이해도를 높이고자 기획하였습니다. <br>
네이버웍스, 다우오피스, 시프티 등을 참고하였습니다.

<details>
<summary><b>전체 기능 펼치기</b></summary>
<div markdown="1">

### 3.1. 팀원별 기능
  
- **서준영(조장)** - 게시판 기능
- **조은진(형상관리)** - 근태관리 기능
- **권지은(DB관리)** - 급여관리, 문서관리 기능
- **권효정(이슈관리)** - 구성원, 주소록, 관리자 기능
- **곽우진(일정관리)** - 전자결재 기능
- **김소라(노션관리)** - 업무관리 기능

### 3.2. 기능 상세

- **구성원**
  - 회원가입
  - 로그인/로그아웃
  - 아이디/비밀번호찾기
  - 마이페이지

- **주소록**
  - 조직주소록
  - 외부주소록
  - 사원현황조회

- **관리자**
  - 구성원 승인
  - 구성원 관리
  - 운영자 관리
  
- **근태관리**
  - 일일근태관리
  - 근태현황조회
  - 휴가관리
  
- **급여관리**
  - 급여명세서
  - 급여정산
  - 급여관리
  
- **전자결재**
  - 서명관리
  - 결재문서 작성
  - 결재승인/반려
  - 결재문서함

- **문서관리**
  - 전체문서관리
  - 결재문서관리
  - 일반문서관리

- **업무관리**
  - 일정관리
  - 할일관리
  
- **게시판**
  - 공지사항
  - 커뮤니티
  - 설문/투표
  
</div>
</details>

<br>

## 4. ERD 설계
[ERD Cloud]()를 사용하여 공동 작업
<details>
<summary><b>전체 테이블 보기</b></summary>

![FORWORKS](https://user-images.githubusercontent.com/96437859/203141175-88475012-a2f6-433f-b8e4-a87cf6cc93e4.png)

</details>

<br>

## 5. 담당 기능

> ### 구성원
- #### 로그인/로그아웃
  - 로그인을 하지 않으면 하위페이지 이용이 불가능
  - 화면 크기에 따른 반응형 화면 구현
  - cookie를 사용한 **아이디 저장** 기능
  - spring security를 사용한 **비밀번호 암호화**
  - filter를 사용한 **접근제어**
  <br>
  <details>
  <summary><b>화면 미리보기</b></summary>

  ![로그인](https://user-images.githubusercontent.com/96437859/203422142-4b18dbc9-267b-4e69-a20a-34bd48893eb7.png)

  </details>

- #### 회원가입
  - 그룹웨어를 이용하기 위한 회원가입 페이지, 가입시 관리자의 승인이 추가로 필요
  - ajax를 사용한 **아이디 중복검사**, JavaScript를 사용한 **비밀번호, 이메일 유효성검사**
  - **다음 주소검색 api**를 사용한 주소 입력
  - alert대신 bootstrap5의 toast를 사용한 알림창 구현
  <br>
  <details>
  <summary><b>화면 미리보기(일부)</b></summary>

  ![회원가입](https://user-images.githubusercontent.com/96437859/203424213-5f76c360-855a-4ac5-adb0-0a5dee185f1f.png)

  </details>
  
- #### 아이디/비밀번호 찾기
  - 성명, 이메일 입력을 통한 아이디 찾기와 아이디, 성명, 이메일 입력을 통한 비밀번호 찾기
  - 아이디 찾기는 ajax로 구현
  - 비밀번호 찾기는 **java smtp**와 **gmail api**를 사용하여 **임시비밀번호 발급**
- #### 마이페이지
  - **회원정보수정, 프로필사진등록, 급여계좌설정, 비밀번호 재설정**을 할 수 있는 마이페이지
  - commons-fileuploder를 사용한 **파일 업로드**와 수정/삭제
  <br>
  <details>
  <summary><b>화면 미리보기</b></summary>

  ![마이페이지 프로필변경](https://user-images.githubusercontent.com/96437859/203422744-a4fca65a-7635-419a-a173-fa8541fd638e.gif)

  </details>
  <br>
  
> ### 주소록
- #### 조직주소록 (전체, 중요, 부서)
  - 전체주소록, 중요주소록, 부서별주소록으로 구성된 조직주소록 페이지
  - 공통적으로 **페이징처리, 정렬(이름), 키워드검색**이 가능
  - 페이징은 **rowbounds**로 처리, 정렬/키워드 검색은 **mybatis의 동적쿼리**를 사용
  - **즐겨찾기 체크박스**를 통해 중요주소록에 원하는 사원을 등록, ajax와 JS를 사용하여 구현
  <br>
  <details>
  <summary><b>화면 미리보기</b></summary>

  ![전체_주소록](https://user-images.githubusercontent.com/96437859/203422903-c40ed0db-6bd1-46e9-984d-20eadfe6c968.gif)

  </details>
  
- #### 외부주소록
  - 외부주소록을 등록하고, 주소록 각 행을 클릭하여 수정하거나 삭제하는 페이지
  - 페이징처리, 키워드검색, 정렬(이름)
  <br>
  <details>
  <summary><b>화면 미리보기</b></summary>

  ![외부_주소록](https://user-images.githubusercontent.com/96437859/203423109-a480efa4-67ac-421b-8464-d9915598676b.gif)

  </details>
  
- #### 사원현황조회
  - 주소록 프로필 사진 옆에 각 사원의 연락 가능 상태가 표시됨
  - 상단 카드에서 자신의 상태를 변경할 수 있으며, ajax를 사용
  <br>
> ### 관리자
- #### 관리자 로그인/로그아웃
  - 별도의 url을 통해 로그인 페이지에 접속
  - 관리자 로그인을 하지 않으면 관리자 페이지에 접속할 수 없음
  - filter를 사용한 **접근제어**
  - spring security를 사용한 **비밀번호 암호화**
  <br>
  <details>
  <summary><b>화면 미리보기</b></summary>

  ![관리자로그인](https://user-images.githubusercontent.com/96437859/203423607-f244319f-7792-430d-b427-901ec46758c6.png)

  </details>
  
- #### 구성원 승인
  - 회원가입을 신청한 구성원을 승인하거나 거절하는 페이지
  - 추가정보입력을 통해 구성원으로 등록하거나 거절버튼을 통해 삭제
  - 거절은 **sweetalert**를 사용
  - 페이징 처리
  <br>
  <details>
  <summary><b>화면 미리보기</b></summary>

  ![구성원 승인](https://user-images.githubusercontent.com/96437859/203423649-573b8ba3-c921-49b9-9bad-90977ca54415.gif)

  </details>
  
- #### 구성원 관리
  - 조직의 전체 구성원을 조회하고 관리할 수 있는 페이지
  - **페이징처리, 정렬(이름, 계정상태), 키워드 검색**이 가능
  - 사원을 클릭하여 사원 정보를 수정하거나, **이용상태(일시정지, 일시정지 해제, 구성원삭제)를 변경**
  - 상태변경은 ajax로 구현
  <br>
  <details>
  <summary><b>화면 미리보기</b></summary>

  ![구성원관리](https://user-images.githubusercontent.com/96437859/203423707-81879b5e-4a90-4e3d-8077-3928fea7e748.gif)

  </details>
  
- #### 운영자 관리
  - 각 기능의 담당 관리자를 지정하거나 삭제할 수 있는 페이지
  - 부관리자/게시판관리자/결재문서관리자/예약관리자를 각각 설정
  - 관리자 추가는 **직무/직급/키워드(선택)으로 검색**하여 조회된 결과 중에서 지정
  - 삭제는 ajax로 구현
  <br>
  <details>
  <summary><b>화면 미리보기</b></summary>

  ![관리자_지정](https://user-images.githubusercontent.com/96437859/203423759-ed097b0a-ff5b-4cea-98cd-c0ad36e8ef24.gif)

  </details>

> #### 더미데이터 제작
  - **PL/SQL 프로시저**를 사용하여 대량의 구성원 더미데이터 작성
> #### 공통
  - Spring Framework 기반 CRUD
  - MVC 패턴 사용
  - JSP, EL, jstl을 사용한 화면구현

<br>

## 6. 회고
> 그룹웨어를 기존에 사용해보지 않아 기획 단계나 기능에 대한 이해를 하는데 시간이 다소 걸렸으나 <br>
> 그룹웨어를 공부하며 업무에 대한 이해도가 상승되었던 것 같다. <br>
> Spring과 Mybatis를 사용하여 조금 더 효율적이고 유지보수에 강한 코드를 작성해보려고 노력한데 의의가 있었다. <br>
> 다 적용해보지는 못했지만 다양한 화면 템플릿이나 API 적용을 시도해보며 API에 대해 배울 수 있었다. <br>

> 기획했던 기능들을 시간 내에 모두 구현할 수 있었어서 뿌듯했고,
> 구성원 기능을 빠르게 구현하느라 로그인/회원가입 기능이 조금 아쉬웠는데
> 다음 프로젝트 구현시 Spring Security에 대해 학습하여 보안성을 높여 기능을 구현하고자 하는 마음이 들었다.

<br>

## 7. 링크 모음
- [개인 진행사항 Notion](https://hyojunnii.notion.site/FOR-WORKS-4c0a1902ee6940cb8de3e19e5caf11f5) <br>
- [팀 깃허브](https://github.com/eunn-jin/ForWorks) <br>
- [ERD Cloud](https://www.erdcloud.com/d/uYeraQMbuvQwe2hML) <br>
- [팀 노션](https://www.notion.so/4-For-Works-16c4ddd42ef04609b2fa219dc7c98497) <br>
- [팀 피그마](https://www.figma.com/file/LyiHOcQc6ZG8S2SZzQVwbU/for-works?node-id=4%3A72&t=046S76ium0voUMso-0)
