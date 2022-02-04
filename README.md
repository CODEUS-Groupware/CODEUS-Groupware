# CODEUS-Groupware
<br>

![GitHub repo size](https://img.shields.io/github/repo-size/gh-yu/CODEUS-Groupware) &nbsp; ![GitHub contributors](https://img.shields.io/github/contributors/gh-yu/CODEUS-Groupware) &nbsp; ![GitHub top language](https://img.shields.io/github/languages/top/gh-yu/CODEUS-Groupware)

### 코드어스 : 그룹웨어 - 통합업무 플랫폼 (Spring Framework 기반 웹 프로젝트)
<br>

[결과물 바로가기](#결과물)

## 프로젝트 개요
코로나 장기화로 인한 재택근무의 증가로 비대면 업무에 적합한 그룹웨어의 필요성이 증가하고 있습니다. 원활한 의사소통과 정보 공유, 신속한 의사 결정이 이루어질 수 있는 업무 환경을 제공하며 편리하게 이용할 수 있는 그룹웨어 시스템을 만들자는 목표로 프로젝트를 기획하였습니다. 

##### 프로젝트 기간 : 2021.12.06 ~ 2022.01.26
## 개발 환경 
    Server : Apache Tomcat 9.0
    Database : Oracle 18c
    Development Tool :  Spring Tool Suite  3.9.13, sqlDeveloper 21.2.1, Visual Studio code
    Framework : MyBatis 3.4.6, Spring 5.3.13
    Build Tool : Maven 3.8.4
    Development Language :  JAVA 8 , HTML5, CSS3, JavaScript, jQuery, SQL, JSP, Ajax
    형상관리 : Github, Sourcetree, ERDCloud, Figma, Notion
    Open API : Summer Note, FullCalender
    Design tool : Bootstrap4

## ERD
![CODEUS ERD](https://user-images.githubusercontent.com/78662802/152368500-53cfe6c6-657f-4957-980d-68edb7c8f51a.png)
## 구현 기능
[회원]
- 회원 가입, 로그인, 로그아웃, 아이디 찾기, 비밀번호 찾기, 이메일 인증, 회원 정보 수정, 스크랩 게시글 관리

[근태 관리]
- 근태 관리 : QR코드를 활용한 출퇴근 기록 남기기, 근무 상태 변경, 주차별 근무 기록(출퇴근, 근태내역) 조회
- 연차 관리 : 사원 연차 생성, 개인 연차 조회(총 연차, 사용 연차, 남은 연차), 연차신청내역 조회

[캘린더]
- 사내 캘린더 일정 공유, 개인 캘린더
- Full calendar API를 활용한 일정 조회/등록/수정/삭제

[채팅]
- 1:1 채팅 기능
- 채팅 상대 검색, 채팅방 개설

[커뮤니티 게시판]
- 자유 게시판, 중고거래 게시판
- 게시글 조회/작성/수정/삭제, Summernote API 사용
- 댓글 조회/작성/수정/삭제
- 검색, 스크랩, 신고 기능

[공지사항 게시판]
- 게시글 조회/작성/수정/삭제, Summernote API 사용
- 댓글/대댓글 조회/작성/수정/삭제
- 검색, 스크랩 기능

[자료실]
- 드라이브 형식, 자료 조회/등록/수정/삭제
- 폴더 생성/삭제/자료 이동
- 자료실 최대 용량 설정, 현재 용량 조회

[주소록] 
- 사내 주소록 조회, 검색 기능

[회의실 예약]
-  회의실 조회, 예약 등록/취소, 예약 내역 검색

[관리자 페이지]
- 사원 관리 :  사원 목록/상세 조회, 부서별/직급별/사원 이름 검색 기능, 계정 상태 변경(입사, 정상, 중지, 삭제), 사원 정보 수정
- 부서 관리 :  treeview플러그인을 활용한 조직도(부서 및 부서원 목록) 조회, 조직도 내 부서 위치 이동(drag and drop), 부서 등록/수정/삭제
- 직위 관리 : 직위 목록/상세 조회, 직위 등록/수정/삭제
- 회의실 관리 : 회의실 목록/상세 조회, 회의실 등록/수정/삭제
- 신고된 글 관리 : 신고된 글 목록/상세 조회, 신고된 글 삭제 또는 신고 취소 처리

## 결과물
### [메인페이지]

![메인페이지](https://user-images.githubusercontent.com/78662802/152479269-f28f5a2b-2d94-4f2a-ba3f-157ce6ed4efa.png)

### [근태 관리]
![누적 근태현황](https://user-images.githubusercontent.com/78662802/152480307-7a1fb816-adc5-4d68-9689-7611fbbe73d2.png)

### [캘린더]
![사내캘린더 일정등록](https://user-images.githubusercontent.com/78662802/152480063-de75420d-f91c-4e56-b82b-66139a96c909.png)
### [공지사항 게시판]
![공지사항 목록](https://user-images.githubusercontent.com/78662802/152479263-cb4b579b-ca3c-429d-9998-82a54e1035d4.png)
![공지사항 상세](https://user-images.githubusercontent.com/78662802/152479264-cfdeb888-7411-4cb8-a4fa-feb76bb2bda0.png)
![댓글 답댓글png](https://user-images.githubusercontent.com/78662802/152480585-7c351285-db2d-42dc-8654-32a44b37a05b.png)
![공지사항 수정](https://user-images.githubusercontent.com/78662802/152480694-4040e949-4358-482d-89f3-193342c19636.png)

### [자료실]
![자료실](https://user-images.githubusercontent.com/78662802/152479274-87e28fb1-31e9-4fd0-9632-25bb655c89c7.png)
### [회의실 예약]
![회의실 예약](https://user-images.githubusercontent.com/78662802/152479675-31054e65-4d71-4b6c-9154-e1a680045d47.png)

### [중고장터]
![중고장터](https://user-images.githubusercontent.com/78662802/152479275-6abfe76f-2e36-4504-a395-65e6527b53ee.png)
### [주소록]
![주소록 검색](https://user-images.githubusercontent.com/78662802/152479767-94e6e1e4-8a14-44cc-849d-9e8f2435e856.png)

### [마이페이지 - 스크랩 관리]
![스크랩 관리](https://user-images.githubusercontent.com/78662802/152479271-bfcae3d5-89c9-4918-89c9-a81a3985bc51.png)
### [관리자페이지 - 부서 관리]
![부서관리-조직도](https://user-images.githubusercontent.com/78662802/152479496-7d3af94b-454d-40d2-85a4-5a43dac6e72b.png)

### [관리자페이지 - 사원 관리]
![사원 관리](https://user-images.githubusercontent.com/78662802/152480390-9aed672e-1d75-4373-8495-83b90052aa92.png)

<br>

## 특징
- MVC 패턴에 기반한 웹 어플리케이션 개발 
- Transaction 처리로 데이터의 무결성 보장
- AOP를 이용한 로그처리
- Interceptor를 이용한 페이지 접근 권한 설정
- Bcrypt를 이용한 비밀번호 암호화 처리
<!-- - DI (Dependency Injection) 패턴을 적용하여 불필요한 의존관계 해소 
- annotation 사용으로 설정 파일을 간결화, view 페이지와 객체 또는 메소드의 맵핑을 명확하게 함 -->

<!-- 산출물 링크 : 구글 드라이브 링크 -->